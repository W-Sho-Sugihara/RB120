# # class Person 
# #     attr_accessor :first_name, :last_name

# #   def initialize(full_name)
# #     parse_full_name(full_name)
# #   end


# #   def name
# #     "#{self.first_name} #{self.last_name}"
# #   end

# #   def name=(full_name)
# #     parse_full_name(full_name)
# #   end

# #   def parse_full_name(full_name)
# #     parts = full_name.split(' ')
# #     @first_name =  parts.shift
# #     @last_name = parts.empty? ? '' : parts.shift
# #   end

# #   def to_s
# #     name()
# #   end
# # end

# # bob = Person.new('Robert')
# # bob.name                  # => 'Robert'
# # bob.first_name            # => 'Robert'
# # bob.last_name             # => ''
# # bob.last_name = 'Smith'
# # bob.name                  # => 'Robert Smith'
# # bob.name = "John Adams"
# # bob.first_name            # => 'John'
# # bob.last_name             # => 'Adams'

# # rob = Person.new('Robert Smith')
# # bob = Person.new('Robert Smith')

# # rob.object_id
# # bob.object_id
# # rob.name == bob.name

# # puts "The persons name is #{bob}"

# # FIND THE CLASS
# # puts "Hello".class
# # puts 5.class
# # puts [1, 2, 3].class

# #= CREATE THE CLASS

# # module Walkable
# #   def walk
# #     puts "Let's go for a walk!!"
# #   end
# # end

# # class Cat
# #   attr_accessor :name
# #   attr_reader :total_cats
# #   include Walkable

# #   COLOR = "purple"
# #   @@total_cats = 0

# #     def initialize(name)
# #       @name = name 
# #       @@total_cats += 1
# #     end

# #     def self.total_num_of_cats
# #       puts @@total_cats
# #     end

# #     def greeting
# #       puts "Hi, my name is #{name}! I'm a #{COLOR} CAT."
# #     end

# #     def self.generic_greeting
# #       puts "Hi! I'm a cat!"
# #     end

# #     def rename(name)
# #     self.name = name
# #     end

# #     def identify
# #       puts self
# #     end

# #     def to_s
# #       "I'm #{name}"
# #     end
# # end

# # kitty = Cat.new("Sophie")
# # tabby = Cat.new("tubby")
# # # kitty.greeting
# # # kitty.name = "Luna"
# # # kitty.greeting
# # # kitty.walk
# # # kitty.identify
# # # Cat.total_num_of_cats
# # puts kitty
# # # =================================

# # class Person
# #   attr_writer :secret
  
# #   def share_secret
# #     secret
# #   end
# #   def compare_secret(other_person)
# #     secret == other_person.secret
# #   end

# #   protected

# #   attr_reader :secret
# # end

# # per1 = Person.new
# # per2 = Person.new
# # per1.secret = "shh....its a secret"
# # per2.secret = "shh....its a different secret"
# # p per1.compare_secret(per2)

# #=========INHERTIANCE-==========================
# # class Pets
 
# #   def run
# #     'running!'
# #   end

# #   def jump
# #     'jumping!'
# #   end
# # end

# # class Cat < animal

# #   def speak
# #     "meow!"
# #   end
# # end

# # class Dog < animal

# #   def speak
# #     'bark!'
# #   end

# #   def swim
# #     'swimming!'
# #   end

# #   def fetch
# #     'fetching!'
# #   end
# # end

# # class Bulldog < Dog

# #   def swim
# #     "can't swim!"
# #   end
# # end

# # teddy = Dog.new
# # puts teddy.speak           # => "bark!"
# # puts teddy.swim           # => "swimming!"

# #=====================INHERITANCE EXERCISES =====================

# module Towable
#   def tow
#     puts "I can tow a trailer!"
#   end
# end

# module Transportation

#   class Vehicle
#     attr_reader :year
  
#     def initialize(year)
#       @year = year
#     end
  
#     def start_engine
#       'Ready to go!'
#     end
#   end
  
#   class Car < Vehicle
      
#   end
  
#   class Truck < Vehicle
#     include Towable
  
#     def initialize(year, bed_type)
#       super(year)
#       @bed_type = bed_type
#     end
  
#     def start_engine(speed)
#       super() + " Drive #{speed}, please!"
      
#     end  
#   end
# end



# truck1 = Transportation::Truck.new(1994, 'short')
# car1 = Transportation::Car.new(2006)



# class Wedding
#   attr_reader :guests, :flowers, :songs

#   def initialize
#     @guests = ["Billy", "Jessica"]
#     @flowers = ["lilies", "tulips"]
#     @songs = ["Eye of the Tiger", "Africa"]
#   end

#   def prepare(preparers)
#     preparers.each do |preparer|
#       preparer.prepare_wedding(self)
#     end
#   end

# end

# class Chef
#   def prepare_wedding(wedding)
#     prepare_food(wedding.guests)
#   end

#   def prepare_food(guests)
#     puts "Preparing food for #{guests[0]} and #{guests[1]}"
#   end
# end

# class Decorator
#   def prepare_wedding(wedding)
#     decorate_place(wedding.flowers)
#   end

#   def decorate_place(flowers)
#     puts "Placing the #{flowers[0]} and #{flowers[1]} on the tables"
#   end
# end

# class Musician
#   def prepare_wedding(wedding)
#     prepare_performance(wedding.songs)
#   end

#   def prepare_performance(songs)
#     puts "Qeueing up #{songs[0]} and #{songs[1]}"
#   end
# end

# joe = Chef.new
# bob = Decorator.new
# linda = Musician.new
# staff = [joe, bob, linda]
# sean_and_dyani = Wedding.new
# sean_and_dyani.prepare(staff)

# class Person
#   attr_accessor :name, :phone_number
# end

# person1 = Person.new
# person1.name = 'Jessica'
# person1.phone_number = '0123456789'
# puts person1.name

# class Person
#   attr_reader :phone_number

#   def initialize(number)
#     @phone_number = number
#   end
# end

# person1 = Person.new(1234567899)
# puts person1.phone_number

# person1.phone_number = 9987654321
# puts person1.phone_number

# class Person
#   attr_writer :age

#   def older_than?(other)
#     age > other.age
#   end

#   protected

#   attr_reader :age

# end

# person1 = Person.new
# person1.age = 17

# person2 = Person.new
# person2.age = 26

# puts person1.older_than?(person2)

# class Person
#   attr_accessor :name
  
#   def name=(name)
#     @name = "Mr. " + name.capitalize
#   end
# end

# person1 = Person.new
# person1.name = 'eLiZaBeTh'
# puts person1.name

# class Person
  

#   def initialize(name)
#     @name = name
#   end

#   def name
#     @name.dup
#   end

# end

# person1 = Person.new('James')
# person1.name.reverse!
# puts person1.name

# class Person
#   def age=(age)
#     @age = age * 2
#   end

#   def age
#     @age * 2
#   end
# end

# person1 = Person.new
# person1.age = 20
# # puts person1.age

# class Banner
#   attr_accessor :message, :width

#   def initialize(message, width = 0)
#     @message = message
#     @width = width >= message.size + 4 ? width : message.size + 2
#   end

#   def to_s
#     [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
#   end

#   private

#   def horizontal_rule
#     "+" + ('-' * width) + '+'
#   end

#   def empty_line
#     "|" + (' ' * width) + '|'
#   end

#   def message_line
#     "|#{@message.center(width)}|"
#   end
# end


# banner = Banner.new('To boldly go where no one has gone before.', 29)
# puts banner
# banner = Banner.new('', 22)
# puts banner
=begin
+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+
=end


# class Pet
#   attr_reader :name

#   def initialize(name)
#     @name = name.to_s
#   end

#   def to_s
    
#     "My name is #{@name.upcase}."
#   end
# end

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name
# puts fluffy
# puts fluffy.name
# puts name

# name = 42
# fluffy = Pet.new(name)
# name += 1
# puts fluffy.name
# puts fluffy
# puts fluffy.name
# puts name

# class Book


#   def initialize(author, title)
#     @author = author
#     @title = title
#   end

#   def title
#     @title
#   end
  
#   def author
#     @author
#   end

#   def to_s
#     %("#{title}", by #{author})
#   end
# end

# book = Book.new("Neil Stephenson", "Snow Crash")
# puts %(The author of "#{book.title}" is #{book.author}.)
# puts %(book = #{book}.)

# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.

# class Car
#   attr_accessor :mileage

#   def initialize
#     @mileage = 0
#   end

#   def increment_mileage(miles)
#     total = mileage + miles
#     self.mileage = total
#   end

#   def print_mileage
#     puts mileage
#   end
# end

# car = Car.new
# car.mileage = 5000
# car.increment_mileage(678)
# car.print_mileage  # should print 5678

# class Rectangle
#   def initialize(height, width)
#     @height = height
#     @width = width
#   end

#   def area
#     @height * @width
#   end
# end

# class Square < Rectangle
# def initialize(side)
#   super(side, side)
# end

#   def to_s
#     "The area of square = #{area.to_s}"
#   end
# end

# square = Square.new(5)
# puts square

# class Pet
#   def initialize(name, age)
#     @name = name
#     @age = age
#   end
# end

# class Cat < Pet
#   attr_accessor :name, :age, :color

#   def initialize(name, age, color)
#     super(name, age)
#     @color = color
#   end

#   def to_s
#     "My cat #{name} is #{age} years old and has #{color} fur."
#   end 
# end

# pudding = Cat.new('Pudding', 7, 'black and white')
# butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
# puts pudding, butterscotch

# class Vehicle
#   attr_reader :make, :model

#   def initialize(make, model)
#     @make = make
#     @model = model
#   end

#   def to_s
#     "#{make} #{model}"
#   end

# end

# class Car < Vehicle
 
#   def wheels
#     4
#   end

# end

# class Motorcycle < Vehicle

#   def wheels
#     2
#   end

# end

# class Truck < Vehicle
#   attr_reader :payload

#   def initialize(make, model, payload)
#     super(make, model)
#     @payload = payload
#   end

#   def wheels
#     6
#   end

# end

# class House
#   attr_reader :price
#   include Comparable

#   def initialize(price)
#     @price = price
#   end

#   def <=>(other_house)
#     price <=> other_house.price
#   end
# end

# home1 = House.new(100_000)
# home2 = House.new(150_000)
# puts "Home 1 is cheaper" if home1 < (home2)
# puts "Home 2 is more expensive" if home2 > (home1)

# class Transform
#   attr_accessor :string

#   def initialize(string)
#     @string = string
#   end

#   def uppercase
#     string.upcase
#   end

#   def self.lowercase(str)
#     str.downcase
#   end
# end

# my_data = Transform.new('abc')
# puts my_data.uppercase
# puts Transform.lowercase('XYZ')

# class Wallet
  
#   include Comparable

#   def initialize(amount)
#     @amount = amount
#   end

#   def <=>(other_wallet)
#     amount <=> other_wallet.amount
#   end

#   protected
#   attr_reader :amount
# end

# bills_wallet = Wallet.new(500)
# pennys_wallet = Wallet.new(465)
# if bills_wallet > pennys_wallet
#   puts 'Bill has more money than Penny'
# elsif bills_wallet < pennys_wallet
#   puts 'Penny has more money than Bill'
# else
#   puts 'Bill and Penny have the same amount of money.'
# end

# class Pet
#   attr_reader :animal, :name

#   def initialize(animal, name)
#     @animal = animal
#     @name = name
#   end

#   def to_s
#     "a #{animal} names #{name}"
#   end
# end

# class Owner
#   attr_reader :name 
#   attr_accessor :pets

#   def initialize(name)
#     @name = name
#     @pets = []
#   end

#   def number_of_pets
#     pets.size
#   end
# end

# class Shelter
#   attr_accessor :adoptions, :unadopted_pets

#   def initialize
#     @adoptions = {}
#     @unadopted_pets = []
#   end

#   def add_to_shelter(pet)
#     unadopted_pets << pet
#   end
 
#   def adopt(adopter, pet)
#     adopter.pets << pet
#     adoptions[adopter] ? adoptions[adopter] << pet : adoptions[adopter] = [pet]
#     unadopted_pets.delete(pet)
#   end

#   def number_of_unadopted_pets
#     unadopted_pets.size
#   end

#   def print_adoptions
#     adoptions.each do |adopter, pets|
#       puts "#{adopter.name} has adopter the folloing pets:"
#       pets.each do |pet|
#         puts pet
#       end
#       puts "\n"
#     end
#   end

#   def print_available_pets
#     puts " The Animal Shelter has the following pets available to adopt:"
#     unadopted_pets.each do |pet|
#       puts pet
#     end
#     puts "\n"
#   end
# end

# shelter = Shelter.new

# butterscotch = Pet.new('cat', 'Butterscotch')
# pudding      = Pet.new('cat', 'Pudding')
# darwin       = Pet.new('bearded dragon', 'Darwin')
# kennedy      = Pet.new('dog', 'Kennedy')
# sweetie      = Pet.new('parakeet', 'Sweetie Pie')
# molly        = Pet.new('dog', 'Molly')
# chester      = Pet.new('fish', 'Chester')
# asta         = Pet.new('dog', 'Asta')
# laddie       = Pet.new('dog', 'Laddie')
# fluffy       = Pet.new('cat', 'Fluffy')
# kat          = Pet.new('cat', 'Kat')
# ben          = Pet.new('cat', 'Ben')
# chatterbox   = Pet.new('parakeet', 'Chatterbox')
# bluebell     = Pet.new('parakeet', 'Bluebell')

# shelter.add_to_shelter(butterscotch)
# shelter.add_to_shelter(pudding)
# shelter.add_to_shelter(darwin)
# shelter.add_to_shelter(kennedy)
# shelter.add_to_shelter(molly)
# shelter.add_to_shelter(sweetie)
# shelter.add_to_shelter(chester)
# shelter.add_to_shelter(asta)
# shelter.add_to_shelter(laddie)
# shelter.add_to_shelter(fluffy)
# shelter.add_to_shelter(kat)
# shelter.add_to_shelter(ben)
# shelter.add_to_shelter(chatterbox)
# shelter.add_to_shelter(bluebell)

# phanson = Owner.new('P Hanson')
# bholmes = Owner.new('B Holmes')


# shelter.adopt(phanson, butterscotch)
# shelter.adopt(phanson, pudding)
# shelter.adopt(phanson, darwin)
# shelter.adopt(bholmes, kennedy)
# shelter.adopt(bholmes, sweetie)
# shelter.adopt(bholmes, molly)
# shelter.adopt(bholmes, chester)
# shelter.print_adoptions
# shelter.print_available_pets
# puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
# puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
# puts "The Animal Shelter has #{shelter.number_of_unadopted_pets} unadopted pets available."

# # P Hanson has adopted the following pets:
# # a cat named Butterscotch
# # a cat named Pudding
# # a bearded dragon named Darwin

# # B Holmes has adopted the following pets:
# # a dog named Molly
# # a parakeet named Sweetie Pie
# # a dog named Kennedy
# # a fish named Chester

# # P Hanson has 3 adopted pets.
# # B Holmes has 4 adopted pets.

# # The Animal Shelter has the following unadopted pets:
# # a dog named Asta
# # a dog named Laddie
# # a cat named Fluffy
# # a cat named Kat
# # a cat named Ben
# # a parakeet named Chatterbox
# # a parakeet named Bluebell
# #    ...

# # P Hanson has 3 adopted pets.
# # B Holmes has 4 adopted pets.
# # The Animal shelter has 7 unadopted pets.

# module Walkable
#   def walk
#       puts "#{self} #{gait} forward."
#   end
# end

# class Human
#   include Walkable
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   def to_s
#     name
#   end

# end

# class Noble < Human
#   attr_reader :title

#   def initialize(title, name)
#     super(name)
#     @title = title
#   end

#   def to_s
#     "#{title} #{name}"
#   end

#   private

#   def gait
#     "stuts"
#   end
# end

# class Person < Human
#   private

#   def gait
#     "strolls"
#   end
# end

# class Feline
#   include Walkable
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   def to_s
#     name
#   end
# end

# class Cat < Feline
#   private

#   def gait
#     "saunters"
#   end
# end

# class Cheetah < Feline
#   private

#   def gait
#     "runs"
#   end
# end

# mike = Person.new("Mike")
# mike.walk
# # => "Mike strolls forward"

# kitty = Cat.new("Kitty")
# kitty.walk
# # => "Kitty saunters forward"

# flash = Cheetah.new("Flash")
# flash.walk
# # => "Flash runs forward"
# byron = Noble.new('Lord', "Byron")
# byron.walk