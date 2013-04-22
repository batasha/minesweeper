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
end

class Tile

  attr_accessor :has_mine, :player_flag, :display_value

  def initialize
    @has_mine = false
    @player_flag = false
    @display_value = "*"
  end


end


class Player


end