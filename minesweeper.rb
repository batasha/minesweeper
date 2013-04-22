class Game

  attr_reader :mine_count, :board

  def initialize(size = 9, mine_count = 10)
    @board = Array.new(size) do
      Array.new(size) {Tile.new}
    end
    @mine_count = mine_count
  end

  def set_board
    mine_locations = []
    while mine_locations.size <= self.mine_count
      mine_locations << rand(81)
      mine_locations = mine_locations.uniq
    end

    # Sets locations of mines on the board.
    mine_locations.each do |loc|
      x = loc / 9
      y = loc % 9

      self.board[x][y].has_mine = true
      p self.board[x][y]
    end

    self.board.each do |x|
      x.each do |y|
        print "#{y.has_mine} "
      end
      print "\n"
    end

  end

    def find_nearby_mines(input_tile)

    end


    def reveal_tile(guess)
      guess_x = guess[0]
      guess_y = guess[1]

      self.board[guess_x][guess_y].revealed = true

      find_nearby_mines(self.board[guess_x][guess_y])
    end

    def won?
      over = true

      self.board.each do |row|
        row.each do |tile|
          if tile.revealed == false || (tile.has_mine == false && tile.player_flag == true)
            over = false
          end
        end
      end

    end

    def over(guessed_tile)
      guessed_tile.has_mine || won?
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