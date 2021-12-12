def count_traverse(world, rows, cols)
  column = 1
  row = 1
  height = world.size
  width = world.first.size

  trees = 0

  while row < height
    column += cols
    column = column % width
    row += rows
    trees += 1 if world[row - 1][column - 1] == '#'
  end

  trees
end

world = File.readlines('./input').map(&:chomp)
puts count_traverse(world, 1, 3)
