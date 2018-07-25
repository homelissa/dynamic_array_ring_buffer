require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0 #length / count needs to be greater than index
    @store = StaticArray.new(@capacity)
    @start_idx = 0
  end

  # O(1)
  def [](index)
    #make sure the store's length is NOT zero. If the store's length is zero, there's no items to get.
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    #make sure the index is within boundary of the count.
    check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    @store[@length - 1] = nil
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length + 1 > @capacity
    # @length += 1
    # @store[length - 1] = val
    @store[length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise 'index out of bounds' if @length == 0
    first_element = @store[0]
    new_arr = StaticArray.new(@capacity)
    @length -= 1
    @length.times do |idx|
      new_arr[idx] = @store[idx + 1]
    end
    @store = new_arr
    first_element
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length + 1 > @capacity

    new_arr = StaticArray.new(@capacity)
    new_arr[0] = val
    @length.times do |idx|
      new_arr[idx + 1] = @store[idx]
    end
    @length += 1
    @store = new_arr
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length


  # index should be greater than @count because static array is zero-indexed
  def check_index(index)
    raise 'index out of bounds' if @length <= index || @length == 0
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!

   new_arr = StaticArray.new(2 * @length)
   @capacity = 2 * @length

   @length.times do |idx|
     new_arr[idx] = @store[idx]
   end

   @store = new_arr
 end


end
