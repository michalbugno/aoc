require 'set'

def count_all_yes(group)
  all = Set.new('a'..'z')
  answers = group.split("\n")
  answers.each do |person|
    all = all & person.split(//)
  end

  all.size
end

groups = File.read(ARGV[0] || './input').split("\n\n")
sum = groups.sum do |group|
  count_all_yes(group)
end

puts sum
