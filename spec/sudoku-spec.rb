require_relative '../app/helpers/solver.rb'

game = Sudoku.new("---26-7-168--7--9-19---45--82-1---4---46-29---5---3-28--93---74-4--5--367-3-18---")

puts "Testing board structure"
board_array = game.board_array
p board_array.length == 9
board_array.each {|row| p row.length == 9}

puts
puts "Testing #to_s method"
p game.to_s == "---26-7-168--7--9-19---45--82-1---4---46-29---5---3-28--93---74-4--5--367-3-18---"

puts
puts "Testing #find_all_empty_cells"
p game.find_all_empty_cells == [0,0]

game2 = Sudoku.new("76926-7-168--7--9-19---45--82-1---4---46-29---5---3-28--93---74-4--5--367-3-18---")
p game2.find_all_empty_cells == [0,5]

puts
puts "Testing #get_row"
p game.get_row(game.find_all_empty_cells) == %w(- - - 2 6 - 7 - 1)

puts
puts "Testing #get_column"
p game.get_column(game.find_all_empty_cells) == %w(- 6 1 8 - - - - 7)
p game2.get_column(game2.find_all_empty_cells) == %w(- - 4 - 2 3 - - 8)

puts
puts "Testing #get_box"
test_box1 = game.get_box(game.find_all_empty_cells)
p test_box1 == %w(- - - 6 8 - 1 9 -)
test_box2 = game2.get_box(game2.find_all_empty_cells)
p test_box2 == %w(2 6 - - 7 - - - 4)

puts
puts "Testing #find_nums_not_used"
p game.find_nums_not_used(test_box1) == %w(2 3 4 5 7)

puts
puts "Testing solve"
puts
puts "Game 1"
game.solve
puts
puts "Solved?"
p game.to_s == "435269781682571493197834562826195347374682915951743628519326874248957136763418259"
puts
game.display_board

puts
game3 = Sudoku.new("--5-3--819-285--6-6----4-5---74-283-34976---5--83--49-15--87--2-9----6---26-495-3")
puts "Game 3:"
game3.solve
puts
puts "Solved?"
p game3.to_s == "475936281932851764681274359517492836349768125268315497153687942794523618826149573"
puts
game3.display_board
