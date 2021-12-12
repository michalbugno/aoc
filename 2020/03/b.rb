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
out = count_traverse(world, 1, 1) *
  count_traverse(world, 1, 3) *
  count_traverse(world, 1, 5) *
  count_traverse(world, 1, 7) *
  count_traverse(world, 2, 1)

puts out
