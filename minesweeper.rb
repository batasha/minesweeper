class Board

  def initialize(size = 9, mine_count = 10)
    board = Array.new(size, Tile.new) {Array.new(size, Tile.new)}
    mine_count = 10
  end

  def set_board
    mine_locations = []
    while mine_locations.size <= mine_count
      mine_locations << rand(81)
      mine_locations = mine_locations.uniq
    end

    # Sets locations of mines on the board.
    mine_locations.each do |loc|
      x = loc / 9
      y = loc % 9

      board[x][y].has_mine = true
    end

    def find_nearby_mines(input_tile)

    end


    def reveal_tile(guess)
      guess_x = guess[0]
      guess_y = guess[1]

      board[guess_x][guess_y].revealed = true

      find_nearby_mines(board[guess_x][guess_y])
    end

end

class Tile

  attr_accessor :has_mine, :player_flag, :display_value, :revealed

  def initialize
    @has_mine = false
    @player_flag = false
    @display_value = "*"
    @revealed = false
  end




end


class Player


end