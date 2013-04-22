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

    board[mine_loc / 9][mine]
end

class Tile

  attr_accessor :has_mine, :player_flag

  def initialize
    @has_mine = false
    @player_flag = false
  end

end


class Player


end