require 'set'

def count_yes(group)
  answers = group.gsub("\n", '').split(//)
  p answers
  Set.new(answers).size
end

groups = File.read(ARGV[0] || './input').split("\n\n")
sum = groups.sum do |group|
  count_yes(group)
end

puts sum
