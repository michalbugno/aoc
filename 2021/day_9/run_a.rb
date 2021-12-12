class Cave
  def initialize(data)
    @data = data
  end

  def neighbours(x, y)
    out = []
    out << @data[x - 1][y] if x > 0
    out << @data[x][y - 1] if y > 0
    out << @data[x + 1][y] if x + 1 < @data.size
    out << @data[x][y + 1] if y + 1 < @data[0].size

    out
  end

  def get(x, y)
    @data[x][y]
  end

  def each_coords
    @data.size.times do |x|
      @data[x].size.times do |y|
        yield x, y
      end
    end
  end
end

cave = File.
  readlines(ARGV[0] || './input').
  map { |line| line.chomp.split(//).map { |s| Integer(s) } }.
  yield_self { |data| Cave.new(data) }

sum = 0
cave.each_coords do |x, y|
  v = cave.get(x, y)
  if cave.neighbours(x, y).all? { |n| n > v }
    sum += (v + 1)
  end
end

puts sum
