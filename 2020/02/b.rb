def valid_password?(range, letter, chars)
  v1 = chars[range.first - 1]
  v2 = chars[range.last - 1]
  (v1 == letter && v2 != letter) || (v1 != letter && v2 == letter)
end

input = File.
  readlines('./input').
  map { |s| s.chomp.split(': ') }.
  map { |left, chars| [left.split(' '), chars] }.
  map { |(range_text, letter), chars| [range_text.split('-'), letter, chars] }.
  map { |(r1, r2), letter, chars| [(Integer(r1)..Integer(r2)), letter, chars] }

out = input.count do |range, letter, chars|
  valid_password?(range, letter, chars)
end

puts out
