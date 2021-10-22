module Hand
  # rubocop:disable Metrics/AbcSize
  def show_player_hand
    puts <<~CRD
      #{'+-------+' * hand.size}
      #{hand.map.with_index { |_, i| ('| ' + hand[i].suit + '     |') }.join}
      #{'|       |' * hand.size}
      #{hand.map.with_index { |_, i| ('| ' + hand[i].value.center(5) + ' |') }.join}
      #{'|       |' * hand.size}
      #{hand.map.with_index { |_, i| ('|     ' + hand[i].suit + ' |') }.join}
      #{'+-------+' * hand.size}
    CRD
  end

  def show_dealer_hand
    puts <<~CRD
      #{'+-----' * (@hand.size - 1)}+-------+
      #{'|     ' * (@hand.size - 1)}| #{hand[0].suit}     |
      #{'|     ' * (@hand.size - 1)}|       |
      #{'|     ' * (@hand.size - 1)}| #{hand[0].value.center(5)} |
      #{'|     ' * (@hand.size - 1)}|       |
      #{'|     ' * (@hand.size - 1)}|     #{hand[0].suit} |
      #{'+-----' * (@hand.size - 1)}+-------+
    CRD
  end
  # rubocop:enable Metrics/AbcSize

  def busted?
    total > 21
  end

  def total
    values = hand.map(&:to_value)
    total = values.sum
    aces = values.count("Ace")
    while  aces > 0 && total > 21
      total -= 10
      aces -= 1
    end
    total
  end

  def empty_hand
    self.hand = []
  end
end

class Participant
  include Hand
  attr_accessor :score, :hand

  def initialize
    @hand = []
    @score = 0
  end

  def stay?
    choice = nil
    loop do
      puts "Would you like to hit or stay? (h/s)"
      choice = gets.chomp.downcase
      break if %w(h s).include?(choice)
      puts "Not a valide choice."
    end
    choice == 's'
  end
end

class Dealer < Participant
  def stay?
    total >= 17
  end
end

class Deck
  attr_accessor :deck, :discard

  def initialize
    @deck = []
    @discard = []
    init_deck
  end

  def init_deck
    Card::SUITS.each do |suit|
      Card::VALUES.each do |value|
        @deck << Card.new(suit, value)
      end
    end
    @deck.shuffle!
  end

  def reshuffle_if_low
    return if deck.size >= 4
    deck.concat(discard.shuffle)
    @discard = []
  end

  def deal_one
    reshuffle_if_low
    @deck.shift
  end

  def display_cards_left_in_deck
    puts "Cards left in deck: #{deck.size}"
  end
end

class Card
  SUITS = %w(♥︎ ♦︎ ♠︎ ♣︎)
  VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10'] +
           ['Jack', 'Queen', 'King', 'Ace']

  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def to_value
    if value.to_i > 0
      value.to_i
    elsif value == "Ace"
      11
    else
      10
    end
  end
end

class Game
  attr_accessor :player, :dealer, :deck

  def initialize
    @player = Participant.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def start
    welcome_message
    loop do
      one_round
      break unless play_again?
    end
    goodbye_message
  end

  def one_round
    deal_cards
    display_table
    player_turn
    display_open_hands
    dealer_turn
    show_results
    discard_and_empty_hands
  end

  def clear_screen
    system 'clear'
  end

  def welcome_message
    puts "Welcome to Twenty One!"
  end

  def deal_cards
    player.hand << deck.deal_one << deck.deal_one
    dealer.hand << deck.deal_one << deck.deal_one
  end

  def display_table
    clear_screen
    dealer.show_dealer_hand
    puts "Dealer's Hand"
    puts ''
    deck.display_cards_left_in_deck
    display_scores
    puts ''
    puts "Player's Hand total: #{player.total}"
    player.show_player_hand
  end

  def display_open_hands
    clear_screen
    dealer.show_player_hand
    puts "Dealer's Hand total: #{dealer.total}"
    puts ''
    deck.display_cards_left_in_deck
    display_scores
    puts ''
    puts "Player's Hand total: #{player.total}"
    player.show_player_hand
  end

  def display_scores
    puts "Player score: #{player.score} Dealer score: #{dealer.score}"
  end

  def player_turn
    until player.busted? || player.stay?
      player.hand << deck.deal_one
      display_table
    end
  end

  def dealer_turn
    return if player.busted?
    until dealer.stay?
      dealer.hand << deck.deal_one
      display_open_hands
    end
  end

  def show_results
    if player.busted? || dealer.busted?
      show_busted
    else
      if_no_bust
    end
  end

  def show_busted
    if player.busted?
      puts "You busted! Dealer wins!"
      dealer.score += 1
    elsif dealer.busted?
      puts "The dealer busted! You win!"
      player.score += 1
    end
  end

  def if_no_bust
    if player.total > dealer.total
      puts "You win!"
      player.score += 1
    elsif dealer.total > player.total
      puts "Dealer wins!"
      dealer.score += 1
    else
      puts "It's a tie?!"
    end
  end

  def play_again?
    choice = nil
    loop do
      puts "Would you like to play again? (y/n)"
      choice = gets.chomp.downcase
      break if %w(y n).include?(choice)
      puts "Not a valid choice."
    end
    choice == 'y'
  end

  def discard_and_empty_hands
    (deck.discard << player.hand).flatten!
    (deck.discard << dealer.hand).flatten!
    player.empty_hand
    dealer.empty_hand
  end

  def goodbye_message
    puts "Thank you for playing! Bye!"
  end
end

Game.new.start
