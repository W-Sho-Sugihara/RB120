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

class CircularQueue
  attr_accessor :stack, :max

  def initialize(buffer)
    @stack = Array.new()
    @max = buffer
  end

  def enqueue(obj)
    stack << obj
    stack.shift if stack.size > max
  end

  def dequeue
    stack.shift
  end
end

queue = CircularQueue.new(3)
p queue.dequeue == nil

queue.enqueue(1)
# p  queue.stack
# p queue.oldest
queue.enqueue(2)

p queue.dequeue == 1
# p queue.stack

queue.enqueue(3)
p queue.stack
queue.enqueue(4)
# p queue.current
# p queue.oldest
# p  queue.stack
p queue.dequeue == 2

queue.enqueue(5)
# p queue.current
p  queue.stack
queue.enqueue(6)
# p queue.current
p  queue.stack
queue.enqueue(7)
# p queue.current
p  queue.stack
p queue.dequeue #== 5
p queue.dequeue #== 6
p queue.dequeue #== 7
p queue.dequeue #== nil

# queue = CircularQueue.new(4)
# puts queue.dequeue == nil

# queue.enqueue(1)
# queue.enqueue(2)
# puts queue.dequeue == 1

# queue.enqueue(3)
# queue.enqueue(4)
# puts queue.dequeue == 2

# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)
# puts queue.dequeue == 4
# puts queue.dequeue == 5
# puts queue.dequeue == 6
# puts queue.dequeue == 7
# puts queue.dequeue == nil