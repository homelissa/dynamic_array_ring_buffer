require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0 #count
    @store = StaticArray.new(@capacity)
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[(@start_idx + index) % @capacity]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[(@start_idx + index) % @capacity] = val
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    @length -= 1
    @store[(@start_idx + @length) % @capacity]
  end

  # O(1) ammortized
  def push(val)
    resize! if @length + 1 > @capacity
    @store[(@start_idx + @length) % @capacity] = val
    @length += 1
  end

  # O(1)
  def shift
    raise 'index out of bounds' if @length == 0
    first_element = self[0]
    @length -= 1
    @start_idx += 1
    first_element
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length + 1 > @capacity
    @start_idx -= 1
    @length += 1
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise 'index out of bounds' if @length <= index || @length == 0
  end

  def resize!
    new_arr = StaticArray.new(2 * @capacity)

    @length.times do |idx|
      new_arr[(start_idx + idx) % @length] = @store[idx]

    end
    @capacity = 2 * @capacity
    @store = new_arr
    @start_idx = 0
  end
end
