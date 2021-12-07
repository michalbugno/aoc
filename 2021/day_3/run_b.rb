input = File.readlines('./input').map(&:chomp)
bits = input.map { |line| line.split(//) }

def find_bits(bits, challenge)
  index = 0
  while bits.size != 1
    counts = bits.map { |line| line[index] }.tally
    z_count = counts['0'] || 0
    o_count = counts['1'] || 0
    significant = challenge.call(z_count, o_count)
    bits = bits.select { |line| line[index] == significant }
    index += 1
  end

  bits.first.join('')
end


oxygen_bin = find_bits(bits, ->(z, o) { o >= z ? '1' : '0' })
co2_bin = find_bits(bits, ->(z, o) { z <= o ? '0' : '1' })

oxygen = oxygen_bin.to_i(2)
co2 = co2_bin.to_i(2)
p oxygen, co2
puts oxygen * co2
