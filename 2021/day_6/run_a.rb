fish = File.read(ARGV[0] || './input').split(',').map { |s| Integer(s) }

18.times do
  p fish
  new_fish = []
  fish = fish.map do |lanternfish|
    new_value = lanternfish - 1
    if lanternfish == 0
      new_value = 6
      new_fish.push(8)
    end
    new_value
  end
  fish.concat(new_fish)
end
p fish.size
