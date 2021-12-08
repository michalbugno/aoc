input = File.readlines(ARGV[0] || './input')
total = input.sum do |line|
  _, out = line.split(' | ')
  out.split(' ').count { |num| [2, 3, 4, 7].include?(num.size) }
end

puts total
