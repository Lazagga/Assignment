data = [3, 5, -2, 4, 6, -1, 2, 8, 0, 100, 7]

max_sum = 0
max_start = -1
max_end = -1

current_sum = 0
current_start = nil

data.each_with_index do |value, index|
  break if value == 0

  if value <= 0
    current_sum = 0
    current_start = nil
    next
  end

  if current_start.nil?
    current_start = index
    current_sum = 0
  end

  current_sum += value

  # Strict comparison preserves the earliest segment on ties.
  if current_sum > max_sum
    max_sum = current_sum
    max_start = current_start
    max_end = index
  end
end

puts "max_sum = #{max_sum}"
puts "start = #{max_start}"
puts "end = #{max_end}"
