# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    @store = RingBuffer.new
    @max = 0
  end

  def enqueue(val)
    @max = val if val > max
    @store.push(val)
  end

  def dequeue
    @store.shift
    @max = @store[0]
    @store.length.times do |i|
      @max = @store[i] if @store[i] > @max
    end
    @max
  end

  def max
    @max
  end

  def length
    @store.length
  end

end
