# # PRIVACY

# class Machine

#   def initialize
#     @switch = :off
#   end

#   def start
#     flip_switch(:on)
#   end

#   def stop
#     flip_switch(:off)
#   end

#   def read_switch
#     @switch
#   end

#   private

#   attr_accessor :switch

#   def flip_switch(desired_state)
#     self.switch = desired_state
#   end
# end

# a = Machine.new
# a.start
# puts a.read_switch

# FIXED ARRAY ==================================

# class FixedArray
#   attr_accessor :array
  
#   def initialize(num)
#     @array = [nil] * 5
#   end

#   def [](i)
#     array.fetch(i)
#   end

#   def []=(i, e)
#     self[i]
#     array[i] = e
#   end

#   def to_a
#     array.clone
#   end

#   def to_s
#     array.to_s
#   end
# end
# fixed_array = FixedArray.new(5)

# puts fixed_array[3] == nil
# puts fixed_array.to_a == [nil] * 5

# fixed_array[3] = 'a'
# puts fixed_array[3] == 'a'
# puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

# fixed_array[1] = 'b'
# puts fixed_array[1] == 'b'
# puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

# fixed_array[1] = 'c'
# puts fixed_array[1] == 'c'
# puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

# fixed_array[4] = 'd'
# puts fixed_array[4] == 'd'
# puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
# puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

# puts fixed_array[-1] == 'd'
# puts fixed_array[-4] == 'c'

# begin
#   fixed_array[6]
#   puts false
# rescue IndexError
#   puts true
# end

# begin
#   fixed_array[-7] = 3
#   puts false
# rescue IndexError
#   puts true
# end

# begin
#   fixed_array[7] = 3
#   puts false
# rescue IndexError
#   puts true
# end

# Circular Queue =======================

# class CircularQueue
#   attr_accessor :stack, :max

#   def initialize(buffer)
#     @stack = Array.new()
#     @max = buffer
#   end

#   def enqueue(obj)
#     stack << obj
#     stack.shift if stack.size > max
#   end

#   def dequeue
#     stack.shift
#   end
# end

# queue = CircularQueue.new(3)
# p queue.dequeue == nil

# queue.enqueue(1)
# # p  queue.stack
# # p queue.oldest
# queue.enqueue(2)

# p queue.dequeue == 1
# # p queue.stack

# queue.enqueue(3)
# p queue.stack
# queue.enqueue(4)
# # p queue.current
# # p queue.oldest
# # p  queue.stack
# p queue.dequeue == 2

# queue.enqueue(5)
# # p queue.current
# p  queue.stack
# queue.enqueue(6)
# # p queue.current
# p  queue.stack
# queue.enqueue(7)
# # p queue.current
# p  queue.stack
# p queue.dequeue #== 5
# p queue.dequeue #== 6
# p queue.dequeue #== 7
# p queue.dequeue #== nil

# # queue = CircularQueue.new(4)
# # puts queue.dequeue == nil

# # queue.enqueue(1)
# # queue.enqueue(2)
# # puts queue.dequeue == 1

# # queue.enqueue(3)
# # queue.enqueue(4)
# # puts queue.dequeue == 2

# # queue.enqueue(5)
# # queue.enqueue(6)
# # queue.enqueue(7)
# # puts queue.dequeue == 4
# # puts queue.dequeue == 5
# # puts queue.dequeue == 6
# # puts queue.dequeue == 7
# # puts queue.dequeue == nil

# Stack Machine Interpretation =====================
=begin
n Place a value n in the "register". Do not modify the stack.
PUSH Push the register value on to the stack. Leave the value in the register.
ADD Pops a value from the stack and adds it to the register value, storing the result in the register.
SUB Pops a value from the stack and subtracts it from the register value, storing the result in the register.
MULT Pops a value from the stack and multiplies it by the register value, storing the result in the register.
DIV Pops a value from the stack and divides it into the register value, storing the integer result in the register.
MOD Pops a value from the stack and divides it into the register value, storing the integer remainder of the division in the register.
POP Remove the topmost item from the stack and place in register
PRINT Print the register value
=end

# class MiniLangError < StandardError; end
# class StackEmptyError < MiniLangError; end
# class WrongTokenError < MiniLangError; end

# class Minilang
#   attr_accessor :register, :stack

#   def initialize(string)
#     @register = 0
#     @stack = []
#     run_machine(string)
#   end

#   def run_machine(instructions)
#     instructions.split.each do |code|
#       if %w(push pop sub add mult div print mod).include?(code.downcase)
#         self.send(code.downcase)
#       elsif code == code.to_i.to_s
#         @register = code.to_i
#       else
#         raise WrongTokenError, "Invalid Code: #{code}"
#       end
#     end
#   end

#   def push
#     stack << register
#   end

#   def pop
#     raise StackEmptyError, "Stack Empty!" if @stack.empty? 
#     @register = stack.pop
#   end

#   def sub
#     @register = register - pop
#   end

#   def add
#     @register = register + pop
#   end

#   def mult
#     @register = register * pop
#   end

#   def div
#     @register = register / pop
#   end

#   def mod
#     @register = register % pop
#   end

#   def print
#     puts register
#   end

# end

# Minilang.new('5 PUSH 3 MULT PRINT')#.eval
# # 15

# Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT')#.eval
# # 5
# # 3
# # 8

# Minilang.new('5 PUSH 10 PRINT POP PRINT')#.eval
# # 10
# # 5

# Minilang.new('5 PUSH POP POP PRINT').eval
# # Empty stack!

# Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ')#.eval
# # 6

# Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ')#.eval
# # 12

# Minilang.new('-3 PUSH 5 XSUB PRINT')#.eval
# # Invalid token: XSUB

# Minilang.new('-3 PUSH 5 SUB PRINT')#.eval
# # 8

# Minilang.new('6 PUSH')#.eval
# # (nothing printed; no PRINT commands)

# Guessing Game ==========================================
# class RandomNumber
#   attr_reader :random_number
#   def initialize
#     @random_number = rand(100)
#   end
# end



# class GuessingGame
#   attr_accessor :number, :guesses_left, :guess, :low, :high
  
#   def initialize(low, high)
#     @low = low
#     @high = high
#     @number = reset(low,high)
#     @guesses_left = Math.log2(high - low).to_i + 1
#     @guess = nil
#   end

#   def play
#     display_welcome

#     loop do
#       display_guesses_left
#       enter_a_guess
#       too_low_or_too_high
#       increment_guesses_left
#       break if guesses_zero? or won?
#     end
#     display_guesses_zero
#     display_if_won
#     reset(low, high)
#   end

#   def display_welcome
#     puts "Welcome to Guess a Number!!"
#   end

#   def display_guesses_left
#     puts "You have #{guesses_left} remaining."
#   end

#   def enter_a_guess
#     puts "Enter a number between #{low} and #{high}."
#     loop do
#       @guess = gets.chomp.to_i
#       break if (low..high).to_a.include?(guess)
#       puts "Not a valid number. Try again."
#     end
#   end

#   def too_low_or_too_high
#     if too_high?
#       puts "Your guess is too high."
#     elsif too_low?
#       puts "Your guess is too low."
#     end
#   end

#   def too_high?
#     guess > number
#   end

#   def too_low?
#     guess < number
#   end

#   def guesses_zero?
#     guesses_left == 0
#   end

#   def won?
#     guess == number
#   end

#   def increment_guesses_left
#     @guesses_left -= 1
#   end

#   def display_guesses_zero
#     puts "You have no more guesses. You Lost!" if guesses_zero?
#   end

#   def display_if_won
#     puts "You won!!!" if won?
#   end

#   def reset(low, high)
#     (low..high).to_a.sample
#   end
# end

# game = GuessingGame.new(501, 1500)
# game.play
# =begin
# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 75
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 85
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 0
# Invalid guess. Enter a number between 1 and 100: 80

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 81
# That's the number!

# You won!

# game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 50
# Your guess is too high.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 25
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 37
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 31
# Your guess is too low.

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 34
# Your guess is too high.

# You have 2 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have 1 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have no more guesses. You lost!
# =end
class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  attr_accessor :deck

  def initialize
    @deck = []
    shuffle_deck
  end

  def shuffle_deck
    SUITS.each do |suit|
      RANKS.each do |rank|
        @deck << Card.new(rank, suit)
      end
    end
    @deck.shuffle!
  end

  def draw
    card = @deck.shift
    shuffle_deck if @deck.empty?
    card
  end
end

class Card
  include Comparable
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    case rank
    when "Ace"   then 14
    when "King"  then 13
    when "Queen" then 12
    when "Jack"  then 11
    else         rank
    end
  end

  def <=>(other_card)
    self.value <=> other_card.value
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class PokerHand
  include Comparable
  HAND_STRENGTH = ['High card', 'Pair', 'Two pair', 'Three of a kind', 'Straight', 'Flush', 'Full house', 'Four of a kind', 'Straight flush', 'Royal flush']

  attr_reader :hand

  def initialize(deck)
    @deck = deck
    @hand = []
    7.times { |_| hand << deck.draw }
  end

  def print
    puts hand
  end

  def <=>(other_player)
    # if evaluate == "High card" && other_player.evaluate == "High card"
    #   hand.map(&:value).max <=> other_player.hand.map(&:value).max
    # else
      HAND_STRENGTH.index(evaluate) <=> HAND_STRENGTH.index(other_player.evaluate)
    # end
  end

  def who_wins?(other_player)
    puts "You have a #{self.evaluate} and opponent has a #{other_player.evaluate}."

    if evaluate > other_player.evaluate
      puts "You win!!"
    elsif evaluate < other_player.evaluate
      puts "You lose!!"
    else 
      puts "Its a tie!"
    end
  end

  def select_best_5card_hand
    possible_hand_values = @hand.combination(5).map { |hand| evaluate(hand) }
    max_hand_value_index = possible_hand_values.map { |hand| HAND_STRENGTH.index(hand) }.max
    max_hand = (@hand.combination(5).select { |hand| 
      evaluate(hand) == HAND_STRENGTH[max_hand_value_index]}.first)
    puts max_hand, evaluate(max_hand)  
  end

  def evaluate(cards)
    case
    when PokerHand.royal_flush?(cards)     then 'Royal flush'
    when PokerHand.straight_flush?(cards)  then 'Straight flush'
    when PokerHand.four_of_a_kind?(cards)  then 'Four of a kind'
    when PokerHand.full_house?(cards)      then 'Full house'
    when PokerHand.flush?(cards)           then 'Flush'
    when PokerHand.straight?(cards)        then 'Straight'
    when PokerHand.three_of_a_kind?(cards) then 'Three of a kind'
    when PokerHand.two_pair?(cards)        then 'Two pair'
    when PokerHand.pair?(cards)            then 'Pair'
    else                         'High card'
    end
  end

  private

  def self.royal_flush?(cards)
    self.single_suit(cards) && cards.map(&:value).sort == (10..14).to_a
  end

  def self.straight_flush?(cards)
    self.single_suit(cards) && self.straight?(cards)
  end

  def self.four_of_a_kind?(cards)
    self. nth_of_a_kind(cards,4)
  end

  def self.full_house?(cards)
    self.three_of_a_kind?(cards) && self.pair?(cards)
  end

  def self.flush?(cards)
    cards.map(&:suit).uniq.size == 1
  end

  def self.straight?(cards)
    min, max = cards.map(&:value).minmax
    cards.map(&:value).sort == (min..max).to_a
  end

  def self.three_of_a_kind?(cards)
    self.nth_of_a_kind(cards, 3) 
  end

  def self.two_pair?(cards)
    cards.map(&:value).select { |v| cards.map(&:value).count(v) == 2 }.uniq.size == 2 
  end

  def self.pair?(cards)
    self.nth_of_a_kind(cards, 2)
  end

  def self.nth_of_a_kind(cards, n)
    cards.map(&:value).any? { |v| cards.map(&:value).count(v) == n } 
  end

  def self.single_suit(cards)
    cards.map(&:suit).uniq.size == 1
  end
end

deck = Deck.new
hand = PokerHand.new(deck)
hand1 = PokerHand.new(deck)
hand.print
puts ''
puts hand.select_best_5card_hand



# Danger danger danger: monkey
# patching for testing purposes.

# class Array
#   alias_method :draw, :pop
# end

# # Test that we can identify each PokerHand type.
# hand = PokerHand.new([
#   Card.new(10,      'Hearts'),
#   Card.new('Ace',   'Hearts'),
#   Card.new('Queen', 'Hearts'),
#   Card.new('King',  'Hearts'),
#   Card.new('Jack',  'Hearts')
# ])
# puts hand.evaluate == 'Royal flush'

# hand = PokerHand.new([
#   Card.new(8,       'Clubs'),
#   Card.new(9,       'Clubs'),
#   Card.new('Queen', 'Clubs'),
#   Card.new(10,      'Clubs'),
#   Card.new('Jack',  'Clubs')
# ])
# puts hand.evaluate == 'Straight flush'

# hand = PokerHand.new([
#   Card.new(3, 'Hearts'),
#   Card.new(3, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(3, 'Spades'),
#   Card.new(3, 'Diamonds')
# ])
# puts hand.evaluate == 'Four of a kind'

# hand = PokerHand.new([
#   Card.new(3, 'Hearts'),
#   Card.new(3, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(3, 'Spades'),
#   Card.new(5, 'Hearts')
# ])
# puts hand.evaluate == 'Full house'

# hand = PokerHand.new([
#   Card.new(10, 'Hearts'),
#   Card.new('Ace', 'Hearts'),
#   Card.new(2, 'Hearts'),
#   Card.new('King', 'Hearts'),
#   Card.new(3, 'Hearts')
# ])
# puts hand.evaluate == 'Flush'

# hand = PokerHand.new([
#   Card.new(8,      'Clubs'),
#   Card.new(9,      'Diamonds'),
#   Card.new(10,     'Clubs'),
#   Card.new(7,      'Hearts'),
#   Card.new('Jack', 'Clubs')
# ])
# puts hand.evaluate == 'Straight'

# hand = PokerHand.new([
#   Card.new('Queen', 'Clubs'),
#   Card.new('King',  'Diamonds'),
#   Card.new(10,      'Clubs'),
#   Card.new('Ace',   'Hearts'),
#   Card.new('Jack',  'Clubs')
# ])
# puts hand.evaluate == 'Straight'

# hand = PokerHand.new([
#   Card.new(3, 'Hearts'),
#   Card.new(3, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(3, 'Spades'),
#   Card.new(6, 'Diamonds')
# ])
# puts hand.evaluate == 'Three of a kind'

# hand = PokerHand.new([
#   Card.new(9, 'Hearts'),
#   Card.new(9, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(8, 'Spades'),
#   Card.new(5, 'Hearts')
# ])
# puts hand.evaluate #== 'Two pair'

# hand = PokerHand.new([
#   Card.new(2, 'Hearts'),
#   Card.new(9, 'Clubs'),
#   Card.new(5, 'Diamonds'),
#   Card.new(9, 'Spades'),
#   Card.new(3, 'Diamonds')
# ])
# puts hand.evaluate == 'Pair'

# hand = PokerHand.new([
#   Card.new(2,      'Hearts'),
#   Card.new('King', 'Clubs'),
#   Card.new(5,      'Diamonds'),
#   Card.new(9,      'Spades'),
#   Card.new(3,      'Diamonds')
# ])
# puts hand.evaluate == 'High card'