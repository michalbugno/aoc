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

def traverse(cave, visits)
  small_visits = visits.select { |cave, _| cave.small? }
  return 0 if !small_visits.select { |k, v| %w[start end].include?(k.name) }.select { |k, v| v > 1 }.empty?
  return 0 if small_visits.select { |_, v| v > 1 }.size > 1
  return 1 if cave.name == 'end'

  cave.paths.sum do |target|
    if (target.small? && visits[target] < 2) || !target.small?
      traverse(target, visits.merge(target => visits[target] + 1))
    else
      0
    end
  end
end

def count_paths(caves)
  start = caves.keys.find { |cave| cave.name == 'start' }
  visits = caves.keys.inject({}) { |memo, cave| memo[cave] = 0; memo }
  visits[start] += 1

  traverse(start, visits)
end

caves = {}

data = File.
  readlines(ARGV[0] || './input').
  map(&:chomp).
  each { |data_connection| connect(caves, data_connection) }

result = count_paths(caves)
puts result
