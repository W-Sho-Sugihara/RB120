class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'Spock']

  def initialize(value)
    @value = value
  end

  def rock?
    @value == "rock"
  end

  def paper?
    @value == 'paper'
  end

  def scissors?
    @value == 'scissors'
  end

  def spock?
    @value == 'Spock'
  end

  def lizard?
    @value == 'lizard'
  end

  def >(other_move)
    (rock? && (other_move.scissors?||other_move.lizard?)) ||
      (paper? && (other_move.rock? || other_move.spock?)) ||
      (scissors? && (other_move.paper? || other_move.lizard?)) ||
      (lizard? && (other_move.spock? || other_move.paper?)) ||
      (spock? && (other_move.scissors? || other_move.rock?))
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end

  def to_s
    @value
  end
end

class Rounds
  attr_accessor :data, :number_of_rounds

  def initialize
    @data = {
      'human' => [],
      'computer' => []
      }
      @number_of_rounds = 0
  end

  def add_choice(player, choice)
    data[player] << choice
  end

  def add_round
    self.number_of_rounds += 1
  end

  def display(player_name, computer_name)
    if number_of_rounds != 0
      number_of_rounds.times do |i|
        puts "Round #{i + 1}: #{player_name} chose #{data['human'][i]}, #{computer_name} chose #{data['computer'][i]}"
      end
    end
  end

end

class Player
  attr_accessor :move, :score, :name

  def initialize
    @score = 0
    @name = self.get_name.capitalize
  end

  def add_score
    self.score += 1
  end
end

class Human < Player
  def get_name
    n = ''
    loop do
      puts "Please enter your name."
      n = gets.chomp
      break unless n.empty?
      puts "Please enter a value."
    end
    n
  end

  def choose
    choice = nil
    loop do
      puts "Please pick rock, paper, scissors, lizard or Spock."
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Please enter a valid choice"
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def get_name
    ["R2D2", 'C3PO', 'Rex', 'Bot', 'Fluffy'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  attr_accessor :human, :computer, :rounds

  def initialize
    @human = Human.new
    @computer = Computer.new
    @rounds = Rounds.new
  end

  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."

    if human.move > computer.move
      puts "#{human.name} won!"
      human.add_score
    elsif computer.move > human.move
      puts "#{computer.name} won!"
      computer.add_score
    else
      puts "It's a tie!!"
    end
  end

  def display_score
    puts "#{human.name}'s score is:".ljust(20, ' ') + "#{human.score}"
    puts "#{computer.name}'s score:".ljust(20, ' ') + "#{computer.score}"
  end

  def display_welcome_message
    puts "Welcome to Rock Paper Scissors!"
  end

  def display_goodbye_message
    puts "Thank you for playing, goodbye!"
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer)
      puts "Not a valid choice."
    end

    return false if answer == 'n'
    return true if answer == 'y'
  end

  def play
    display_welcome_message
    loop do
      rounds.display(human.name, computer.name)
      human.choose
      rounds.add_choice('human', human.move)
      computer.choose
      rounds.add_choice('computer', computer.move)
      rounds.add_round
      display_winner
      display_score
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
