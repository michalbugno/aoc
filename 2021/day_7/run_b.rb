values = File.read(ARGV[0] || './input').split(',').map { |x| Integer(x) }

def fuel_matrix(upto)
  fuels = {-1 => 0}
  upto.times do |i|
    fuels[i] = fuels[i - 1] + i
  end
  fuels
end

def needed_fuel(values, target, fuels)
  values.sum { |value| fuels[(value - target).abs] }
end

min, max = values.minmax
fuels = fuel_matrix(max - min + 1)

(max - min).times do |i|
  fuels[i] = fuels[i - 1] + i
end

found_min = Float::INFINITY

(min..max).each do |current|
  current = needed_fuel(values, current, fuels)
  found_min = current if found_min > current
end

puts found_min
