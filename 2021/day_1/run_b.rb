require 'pry'

lines = File.readlines('./input').map { |line| Integer(line) }
slices = lines.each_cons(3)
shifted_slices = lines.drop(1).each_cons(3)
puts slices.zip(shifted_slices).
  select { |_a, b| b }.
  select { |a, b| a.size == 3 && b.size == 3 }.
  count { |a, b| a.sum < b.sum }
