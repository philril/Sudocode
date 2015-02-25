helpers do

class Sudoku
  attr_reader :board_array

  def initialize(board_string)
    @board_array = board_string.split("").each_slice(9).to_a
  end

  def display_board
    @board_array.each {|row| puts row.join(" ")}
  end

  # Returns a nicely formatted string representing the current state of the board
  def to_s
    @board_array.flatten.join("")
  end

  def solved?
    !to_s.include?("-")
  end

  #The following methods are to be used by #solve:

  # #find_all_empty_cells returns the location of the first empty cell as an array
  def find_all_empty_cells
    @board_array.each_index do |i|
      row = @board_array[i]
      row_index = i
      row.each_index do |i|
        char = row[i]
        column_index = i
        if char == "-"
          return [row_index,column_index]
        end
      end
    end
  end

  def get_row(empty_cell_position_array)
    row_index = empty_cell_position_array[0]
    @board_array[row_index]
  end

  def get_column(empty_cell_position_array)
    column_index = empty_cell_position_array[1]
    @board_array.transpose[column_index]
  end

  def get_box(empty_cell_position_array)
    empty_cell_row_index = empty_cell_position_array[0]
    empty_cell_column_index = empty_cell_position_array[1]

    box_top_left_row_index = (empty_cell_row_index / 3) * 3
    box_top_left_column_index = (empty_cell_column_index / 3) * 3

    box_chars = []
    @board_array.each_index do |row_index|
      row = @board_array[row_index]
      if row_index >= box_top_left_row_index && row_index < box_top_left_row_index + 3
        row.each_index do |column_index|
          char = row[column_index]
          if column_index >= box_top_left_column_index && column_index < box_top_left_column_index + 3
            box_chars << char
          end
        end
      end
    end
    return box_chars
  end

  def find_nums_not_used(char_array)
    existing_nums = []
    char_array.each { |char| existing_nums << char if char != "-" }

    default_array = (1..9).to_a.map {|num| num.to_s}
    nums_not_used = []

    default_array.each {|num| nums_not_used << num if existing_nums.include?(num) == false}

    nums_not_used
  end

  def find_unique_num(empty_cell_position_array)
    row = get_row(empty_cell_position_array)
    row_possibles = find_nums_not_used(row)

    column = get_column(empty_cell_position_array)
    column_possibles = find_nums_not_used(column)

    box = get_box(empty_cell_position_array)
    box_possibles = find_nums_not_used(box)

    row_possibles & column_possibles & box_possibles
  end

  def solve
    @board_array.each_index do |row_index|
      row = @board_array[row_index]
      row.each_index do |column_index|
        char = row[column_index]
        num_to_add = find_unique_num([row_index,column_index])
          if char == "-" && num_to_add != nil && num_to_add.length == 1
            @board_array[row_index][column_index] = num_to_add.first
            solve
          end
      end
    end #end first do
  end #end solve method
end #end class

end #end helper