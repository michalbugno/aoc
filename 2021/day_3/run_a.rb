input = File.readlines('./input').map(&:chomp)
counts = {}
input.each do |line|
  line.split(//).each.with_index do |number, index|
    counts[index] ||= {}
    counts[index][number] ||= 0
    counts[index][number] += 1
  end
end

output = Array.new(counts.size)

counts.each do |index, stats|
  if stats['1'] > stats['0']
    output[index] = '1'
  else
    output[index] = '0'
  end
end

gamma_bin = output.join('')
epsilon_bin = output.map { |x| x == '0' ? '1' : '0' }.join('')
gamma = gamma_bin.to_i(2)
epsilon = epsilon_bin.to_i(2)
puts gamma * epsilon
