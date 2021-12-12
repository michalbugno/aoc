require 'pry'

def parse_passport(input)
  input.sub("\n", ' ').split(' ').inject({}) do |memo, entry|
    key, value = entry.split(':')
    memo.merge(key => value)
  end
end

def valid?(passport)
  required_fields = %w[byr iyr eyr hgt hcl ecl pid]
  return false unless required_fields.all? { |field| passport.key?(field) }

  return false unless (1920..2002).include?(Integer(passport.fetch('byr')))
  return false unless (2010..2020).include?(Integer(passport.fetch('iyr')))
  return false unless (2020..2030).include?(Integer(passport.fetch('eyr')))

  height_match = passport.fetch('hgt').match(/^(\d+)(cm|in)$/)
  return false unless height_match
  height = Integer(height_match[1])
  height_unit = height_match[2]
  if height_unit == 'cm'
    return false unless (150..193).include?(height)
  else
    return false unless (59..76).include?(height)
  end

  return false unless passport.fetch('hcl').match(/^#[0-9a-f]{6}$/)
  return false unless %w[amb blu brn gry grn hzl oth].include?(passport.fetch('ecl'))
  return false unless passport.fetch('pid').match(/^[0-9]{9}$/)

  return true
end

passport_inputs = File.read('./input').split("\n\n").map { |passport_input| parse_passport(passport_input) }
valids = passport_inputs.count { |passport| valid?(passport) }
puts valids
