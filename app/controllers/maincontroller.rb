get '/' do
  erb :index
end

get '/board' do
  @board_string = get_board_string
  game = Sudoku.new(@board_string)
  game.solve
  solved_board = game.to_s

  content_type :json
  {
    board_string: @board_string,
    solved_board: solved_board
  }.to_json
end