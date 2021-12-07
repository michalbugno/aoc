require 'dry-struct'

commands = File.readlines('./input').
  map(&:chomp).
  map { |line| line.split(' ') }.
  map { |direction, length| [direction, Integer(length)] }

horizontal_position = 0
depth = 0
aim = 0

commands.each do |direction, length|
  case direction
  when 'forward'
    horizontal_position += length
    depth += (aim * length)
  when 'up' then aim -= length
  when 'down' then aim += length
  else raise direction.inspect
  end
end

puts horizontal_position * depth
