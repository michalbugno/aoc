require 'pry'

def parse_passport(input)
  input.sub("\n", ' ').split(' ').inject({}) do |memo, entry|
    key, value = entry.split(':')
    memo.merge(key => value)
  end
end

def valid?(passport)
  required_fields = %w[byr iyr eyr hgt hcl ecl pid]
  required_fields.all? { |field| passport.key?(field) }
end

passport_inputs = File.read('./input').split("\n\n").map { |passport_input| parse_passport(passport_input) }
valids = passport_inputs.count { |passport| valid?(passport) }
puts valids
