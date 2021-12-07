require 'dry-struct'

commands = File.readlines('./input').
  map(&:chomp).
  map { |line| line.split(' ') }.
  map { |direction, length| [direction, Integer(length)] }

horizontal_position = 0
depth = 0

commands.each do |direction, length|
  case direction
  when 'forward' then horizontal_position += length
  when 'up' then depth -= length
  when 'down' then depth += length
  else raise direction.inspect
  end
end

puts horizontal_position * depth
