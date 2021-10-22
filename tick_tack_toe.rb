require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  def [](i)
    @squares[i].marker
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  # def count_human_marker(squares)
  #   squares.map(&:marker).count(TTTGame::HUMAN_MARKER)
  # end
  # def count_computer_marker(squares)
  #   squares.map(&:marker).count(TTTGame::COMPUTER_MARKER)
  # end

  def three_in_a_row?(line)
    @squares.values_at(*line).map(&:marker).uniq.size == 1
  end

  def three_in_a_row_marker(line)
    @squares.values_at(*line).map(&:marker).uniq.first
  end

  # returns winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      if three_in_a_row?(line) &&
         three_in_a_row_marker(line) != Square::INITIAL_MARKER
        return three_in_a_row_marker(line)
      end
    end
    nil
  end

  def two_in_a_row?(marker)
    !!winning_square(marker)
  end

  def winning_square(marker)
    WINNING_LINES.each do |line|
      if check_for_two_in_a_row(line, marker) 
        return empty_square(line)
      end
    end
    nil
  end

  def check_for_two_in_a_row(line, marker)
    markers = @squares.values_at(*line).map(&:marker)
    grouped_markers = markers.group_by { |x| markers.count(x)}
    grouped_markers[2] == [marker, marker] && grouped_markers[1] == [Square::INITIAL_MARKER]
  end

  def empty_square(line)
    empty_key = @squares.select do |k,_| 
      line.include?(k) && 
      @squares[k].marker == Square::INITIAL_MARKER
    end
    empty_key.keys.first
  end


  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def display_self
    puts <<~BRD
           |     |
        #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}
           |     |
      -----+-----+-----
           |     |
        #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}
           |     |
      -----+-----+-----
           |     |
        #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}
           |     |

    BRD
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_accessor :name, :marker, :score

  def initialize(marker = nil)
    @marker = marker
    @score = 0
  end
end

class TTTGame
  COMPUTER_MARKER = "O"

  attr_reader :board, :human, :computer
  attr_accessor :player_order

  def initialize
    @board = Board.new
    @human = Player.new
    @computer = Player.new(COMPUTER_MARKER)
    @player_order = [@human, @computer]
  end

  def play
    clear_screen
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  def set_name(player)
    case player
    when human    then set_human_player_name
    when computer then set_computer_name
    end
  end

  def set_human_player_name
    name = nil
    loop do
      puts "Please enter your name."
      name = gets.chomp.capitalize
      break unless name.empty?
      puts "Must enter something."
    end
    human.name = name
  end

  def set_computer_name
    computer.name = ['R2D2', 'C3PO', 'Jabba', 'Vader', 'Fett'].sample
  end

  def initial_player_setup
    set_name(human)
    set_player_marker
    set_name(computer)

  end

  def set_player_marker
    marker = nil
    loop do
      puts "Please enter a value other than 'O' to be your marker."
      marker = gets.chomp
      break unless marker.empty? || marker == 'O'
      puts "Must enter a value (cannot be 'O')."
    end
    human.marker = marker
  end

  def main_game
    initial_player_setup 
    loop do
      display_board
      player_move
      update_score
      display_results
      break unless play_again?
      reset
      display_play_again_message
    end
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      display_board_and_clear_screen
      display_score
      rotate_current_player
    end
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ''
  end

  def display_goodbye_message
    puts 'Thank you for playing Tic Tac Toe! Goodbye!'
  end

  def display_board
    puts "#{human.name} is #{human.marker}. #{computer.name} is #{computer.marker}."
    board.display_self
  end

  def display_board_and_clear_screen
    clear_screen
    display_board
  end

  def human_moves
    puts "Choose a square (#{join_or(board.unmarked_keys)}):"
    square = ''
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, thats not a  valid choice."
    end
    board[square] = human.marker
  end

  def computer_moves
    if board.two_in_a_row?(computer.marker)
      board[board.winning_square(computer.marker)] = computer.marker
    elsif board.two_in_a_row?(human.marker)
      board[board.winning_square(human.marker)] = computer.marker
    elsif board[5] == Square::INITIAL_MARKER
      board[5] = computer.marker
    else
      board[board.unmarked_keys.sample] = computer.marker
    end
  end

  def join_or(arr, punc = ', ', sep = 'or')
    case arr.size
    when 1 then arr.join
    when 2 then arr.join(' or ')
    else        "#{arr[0...-1].join(punc)} #{sep} #{arr[-1]}"
    end
  end

  def display_results
    display_board_and_clear_screen
    display_score
    case board.winning_marker
    when human.marker    then puts "You Won!"
    when computer.marker then puts "Computer Won!"
    else                      puts "Its a tie!"
    end
  end

  def display_score
    puts "#{human.name}'s score is #{human.score}"
    puts "#{computer.name}'s score is #{computer.score}"
  end

  def update_score
    case board.winning_marker
    when human.marker    then human.score += 1
    when computer.marker then computer.score += 1
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, must be y or n."
    end
    answer == 'y'
  end

  def reset
    board.reset
    self.player_order = [human, computer]
    clear_screen
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ''
  end

  def clear_screen
    system 'clear'
  end

  def current_player_moves
    case player_order.first
    when human    then human_moves
    when computer then computer_moves
    end
  end

  def rotate_current_player
    self.player_order = player_order.rotate
  end
end

game = TTTGame.new
game.play
