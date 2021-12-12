require 'pry'

class Cave
  attr_reader :name, :paths

  def initialize(name)
    @name = name
    @paths = []
  end

  def connect(cave)
    @paths << cave
  end

  def hash
    @name.hash
  end

  def small?
    @name.downcase == @name
  end

  def eql?(other)
    @name == other.name
  end
end

def connect(caves, data_connection)
  from, to = data_connection.split('-')
  from = Cave.new(from)
  to = Cave.new(to)
  caves[from] ||= from
  caves[to] ||= to
  caves[from].connect(caves[to])
  caves[to].connect(caves[from])
end

def traverse(cave, possibilities)
  return 1 if cave.name == 'end'
  return 0 if possibilities.empty?

  cave.paths.sum do |target|
    if possibilities.include?(target)
      new_possibilities = target.small? ? possibilities - [target] : possibilities
      traverse(target, new_possibilities)
    else
      0
    end
  end
end

def count_paths(caves)
  start = caves.keys.find { |cave| cave.name == 'start' }

  traverse(start, caves.keys - [start])
end

caves = {}

data = File.
  readlines(ARGV[0] || './input').
  map(&:chomp).
  each { |data_connection| connect(caves, data_connection) }

result = count_paths(caves)
puts result
