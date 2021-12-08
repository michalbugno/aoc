def parse_segment(input)
  input.split(//)
end

##
# The difference between displaying 7 and 1 which can be uniquely identified
def find_a(sources)
  one = sources.find { |segment| segment.size == 2 }
  seven = sources.find { |segment| segment.size == 3 }
  a = (seven - one).first
  raise "Cannot find a" unless a

  a
end

##
# We know that (8 - 4 - 7) are 'e | g' and (4 - 1) are 'b | d'
# Since the only numbers with all those pairs on is 6 and 8 and we uniquely identify 8, we can deduce 'f' by removing the two above pairs and 'a' which we found earlier.
def find_f(sources, a)
  one = sources.find { |segment| segment.size == 2 }
  four = sources.find { |segment| segment.size == 4 }
  seven = sources.find { |segment| segment.size == 3 }
  eight = sources.find { |segment| segment.size == 7 }
  e_or_g = eight - four - seven
  b_or_d = four - one
  six = sources.find { |segment| segment.size == 6 && (segment & e_or_g).size == 2 && (segment & b_or_d).size == 2 }

  out = (six - [a] - e_or_g - b_or_d)
  raise "f missing" if out.size != 1

  out.first
end

##
# c is just seven - a - f
def find_c(sources, a, f)
  seven = sources.find { |segment| segment.size == 3 }
  c = (seven - [a] - [f]).first

  raise "c missing" unless c

  c
end

##
# If all a,c,f are present and there are 5 segments on it must be '3'. This means that we can find (d | g)
#
# We know that (b | d) is (4 - c - f).
# We can deduce 'd'.
def find_b_d_g(sources, a, c, f)
  three = sources.find { |segment| segment.size == 5 && segment.include?(a) && segment.include?(c) && segment.include?(f) }
  four = sources.find { |segment| segment.size == 4 }
  d_or_g = three - [a] - [c] - [f]
  b_or_d = four - [c] - [f]

  d = (d_or_g & b_or_d).first
  b = (b_or_d - [d]).first
  g = (d_or_g - [d]).first

  raise "d missing" unless d
  raise "b missing" unless b
  raise "g missing" unless g

  [b, d, g]
end

##
# Based on above we can deduce g since we had b_or_g and found b.
def find_g(sources, a, c, d, f)
  three = sources.find { |segment| segment.size == 5 && segment.include?(a) && segment.include?(c) && segment.include?(f) }
  four = sources.find { |segment| segment.size == 4 }
  d_or_g = three - [a] - [c] - [f]
  b_or_d = four - [c] - [f]

  d = (d_or_g & b_or_d).first

  raise "d missing" unless d
  d
end

def translate(segment, a, b, c, d, e, f, g)
  mapping = {
    a => 'a',
    b => 'b',
    c => 'c',
    d => 'd',
    e => 'e',
    f => 'f',
    g => 'g',
  }
  new_segment = segment.map { |d| mapping.fetch(d) }
  case new_segment.sort
  when %w[a b c e f g] then 0
  when %w[c f] then 1
  when %w[a c d e g] then 2
  when %w[a c d f g] then 3
  when %w[b c d f] then 4
  when %w[a b d f g] then 5
  when %w[a b d e f g] then 6
  when %w[a c f] then 7
  when %w[a b c d e f g] then 8
  when %w[a b c d f g] then 9
  else
    raise "Unknown segement #{new_segment.sort}"
  end
end

def solve(sources, values)
  # target naming
  #   aa
  #  b  c
  #  b  c
  #   dd
  #  e  f
  #  e  f
  #   gg

  a = find_a(sources)
  f = find_f(sources, a)
  c = find_c(sources, a, f)
  b, d, g = find_b_d_g(sources, a, c, f)
  e = (('a'..'g').to_a - [a, b, c, d, f, g]).first
  numbers = values.map do |value|
    translate(value, a, b, c, d, e, f, g)
  end

  Integer(numbers.map(&:to_s).join.gsub(/^0+/, ''))
end

input = File.readlines(ARGV[0] || './input')
displays = input.map do |line|
  left, right = line.split(' | ')
  [
    left.split(' ').map { |i| parse_segment(i) },
    right.split(' ').map { |i| parse_segment(i) },
  ]
end

total = displays.sum do |display|
  solve(display[0], display[1])
end

puts total
