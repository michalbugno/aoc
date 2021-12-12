def valid_password?(range, letter, chars)
  occurrence_count = chars.split(//).count { |l| l == letter }
  range.include?(occurrence_count)
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
