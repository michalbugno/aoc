require 'pry'

class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def hash
    [@x, @y].hash
  end

  def eql?(other)
    @x == other.x && @y == other.y
  end
end

def text_to_point(text)
  x, y = text.split(',').map { |s| Integer(s) }
  Point.new(x, y)
end

def horizontal?(line)
  p1, p2 = line

  p1.y - p2.y == 0
end

def vertical?(line)
  p1, p2 = line

  p1.x - p2.x == 0
end

def diagonal?(line)
  p1, p2 = line

  (p1.x - p2.x).abs == (p1.y - p2.y).abs
end

def traverse(world, line)
  p1, p2 = line
  x1, x2 = [p1.x, p2.x].minmax
  y1, y2 = [p1.y, p2.y].minmax

  diff_x = p1.x - p2.x
  diff_y = p1.y - p2.y

  steps = diff_x.zero? ? diff_y.abs + 1 : diff_x.abs + 1

  if diff_x == 0
    x_change = 0
    y_change = diff_y <=> 0
  elsif diff_y == 0
    x_change = diff_x <=> 0
    y_change = 0
  else
    x_change = diff_x <=> 0
    y_change = diff_y <=> 0
  end

  steps.times do |i|
    point = Point.new(p1.x - i * x_change, p1.y - i * y_change)
    world[point] += 1
  end
end

lines = File.
  readlines(ARGV[0] || './input').
  map { |line| line.chomp.split(' -> ') }.
  map { |a, b| [text_to_point(a), text_to_point(b)] }

world = Hash.new(0)

lines.
  select { |line| horizontal?(line) || vertical?(line) || diagonal?(line) }.
  each { |line| traverse(world, line) }

puts world.values.count { |v| v > 1 }
