class Cave
  def initialize(data)
    @data = data
    @found_basins = 0
    @basins = data.map do |column|
      Array.new(column.size, nil)
    end
  end

  def each_coords
    @data.size.times do |x|
      @data[x].size.times do |y|
        yield x, y
      end
    end
  end

  def unknown_basin?(x, y)
    @data[x][y] < 9 && @basins[x][y].nil?
  end

  def discover_new_basin(x, y)
    @found_basins += 1
    mark_basin(x, y, @found_basins)
  end

  def mark_basin(x, y, number)
    @basins[x][y] = number
    mark_basin(x - 1, y, number) if x - 1 >= 0 && unknown_basin?(x - 1, y)
    mark_basin(x, y - 1, number) if y - 1 >= 0 && unknown_basin?(x, y - 1)
    mark_basin(x + 1, y, number) if x + 1 < @data.size && unknown_basin?(x + 1, y)
    mark_basin(x, y + 1, number) if y + 1 < @data[0].size && unknown_basin?(x, y + 1)
  end

  def basins
    (1..@found_basins).map do |basin|
      @basins.flatten.count { |x| x == basin }
    end
  end
end

cave = File.
  readlines(ARGV[0] || './input').
  map { |line| line.chomp.split(//).map { |s| Integer(s) } }.
  yield_self { |data| Cave.new(data) }

sum = 0
cave.each_coords do |x, y|
  if cave.unknown_basin?(x, y)
    cave.discover_new_basin(x, y)
  end
end

puts cave.basins.sort.reverse.first(3).inject(1) { |v, memo| v * memo }
