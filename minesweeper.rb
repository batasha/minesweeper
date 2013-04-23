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
    end
  end

  def display_board
    self.board.each do |x|
      x.each do |y|
        print "#{y.display_value} "
      end
      print "\n"
    end
    true
  end


  def find_nearby_mines(location)
    x = location[0]
    y = location[1]

    (x - 1..x + 1).each do |i|
      (y - 1..y + 1). each do |j|
        return if board[i][j].display_value != '*' || !(0..9).include?(i) || (i == x && j == y) || board[i][j].nil?

        if board[i][j].has_mine
          board[x][y].nearby_bombs += 1
          board[x][y].checked = true
          return
        else
          board[x][y].display_value = "_"
          board[x][y].checked = true
          find_nearby_mines([i, j])
        end

        if board[x][y].nearby_bombs > 0
          board[x][y].display_value = board[x][y].nearby_bombs.to_s
        end

      end
    end

    board.each do |row|
      row.each do |tile|
        tile.checked = false
      end
    end
  end

  def flag_tile(guess)
    guess_x = guess[0]
    guess_y = guess[1]

    self.board[guess_x][guess_y].player_flag = true
    self.board[guess_x][guess_y].display_value = 'F'

  end

  def reveal_tile(guess)
    guess_x = guess[0]
    guess_y = guess[1]

    self.board[guess_x][guess_y].revealed = true

    if self.board[guess_x][guess_y].has_mine
      puts "You lose."
    else
      find_nearby_mines(guess)
    end

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

  # def lost?(guessed_tile)
 #    guessed_tile.has_mine
 #  end
 #

  # def over?
  #   lost? || won?
  # end


  def run
    self.set_board

    until won? || lost?
      self.display_board

      option = player.get_option
      location = player.get_location

      if option == 'f'
        flag_tile(location)
      elsif option == 'r'
        reveal_tile(location)
      else
        puts 'Invalid input.'
      end

    end
  end

end

class Tile

  attr_accessor :has_mine, :player_flag, :display_value, :revealed, :nearby_bombs

  def initialize
    @has_mine = false
    @player_flag = false
    @display_value = '*'
    @revealed = false
    @nearby_bombs = 0
    @checked = false
  end

  def update_display
    @display_value = 'F'
    @display_value = '_' if @revealed
    @display_value = @nearby_bombs if @nearby_bombs > 0
  end


end


class Player

  def get_option
    print "Reveal or flag? (Type 'r' or 'f'): "
    gets.chomp
  end

  def get_location
    print "Enter x coordinate: "
    x = gets.chomp.to_i
    print "Enter y coordinate: "
    y = gets.chomp.to_i

    [x, y]
  end


end