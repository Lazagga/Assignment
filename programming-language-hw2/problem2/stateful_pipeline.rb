DATA = [3, -1, 4, 0, -2, 5, 8]

def make_greater_than(threshold)
  ->(value) { value > threshold }
end

def make_transformer
  count = 0

  transformer = lambda do |value|
    count += 1
    value * 2
  end

  get_count = -> { count }
  { apply: transformer, get_count: get_count }
end

def process(data, predicate, transformer)
  data.sum do |value|
    predicate.call(value) ? transformer[:apply].call(value) : 0
  end
end

def get_count(transformer)
  transformer[:get_count].call
end

predicate = make_greater_than(2)
transformer = make_transformer

result = process(DATA, predicate, transformer)
count = get_count(transformer)

puts "result = #{result}"
puts "count = #{count}"
