class Counter
  attr_reader :value

  def initialize
    @value = 0
  end

  def increment
    @value += 1
  end

  def decrement
    @value -= 1
  end

  def reset
    @value = 0
  end

  def get_value
    @value
  end

  def print_info
    puts "Counter value = #{@value}"
  end
end

class BoundedCounter < Counter
  def initialize(max_value)
    super()
    @max_value = max_value
  end

  def increment
    @value += 1 if @value < @max_value
  end

  def print_info
    puts "BoundedCounter value = #{@value}, max = #{@max_value}"
  end
end

class StepCounter < Counter
  def initialize(step)
    super()
    @step = step
  end

  def increment
    @value += @step
  end

  def decrement
    @value -= @step
  end

  def print_info
    puts "StepCounter value = #{@value}, step = #{@step}"
  end
end

normal = Counter.new
bounded = BoundedCounter.new(2)
stepped = StepCounter.new(3)

normal.increment
bounded.increment
bounded.increment
bounded.increment
stepped.increment
stepped.decrement

counters = [Counter.new, BoundedCounter.new(1), StepCounter.new(5)]

counters.each do |counter|
  counter.increment
  counter.print_info
end
