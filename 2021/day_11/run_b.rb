require 'pry'

$total_flashes = 0

class Octopus
  attr_reader :energy
  attr_reader :flashed

  def initialize(energy)
    @energy = energy
    @flashed = false
  end

  def increase!
    @energy += 1
  end

  def flashed!
    @flashed = true
  end

  def reset
    @flashed = false
    @energy = 0 if @energy > 9
  end
end

def increase_energy(octopuses)
  octopuses.each { |row| row.each(&:increase!) }
end

def reset(octopuses)
  octopuses.each { |row| row.each(&:reset) }
end

def in_bound?(octopuses, row_index, col_index)
  (0..octopuses.size - 1).include?(row_index) && (0..octopuses[0].size - 1).include?(col_index)
end

def propagate_flash(octopuses, row_index, col_index, self_increase = true)
  return unless in_bound?(octopuses, row_index, col_index)

  # binding.pry if row_index == 2 && col_index == 1

  octopuses[row_index][col_index].increase! if self_increase

  if octopuses[row_index][col_index].energy > 9 && !octopuses[row_index][col_index].flashed
    octopuses[row_index][col_index].flashed!
    $total_flashes += 1
    propagate_flash(octopuses, row_index - 1, col_index - 1)
    propagate_flash(octopuses, row_index - 1, col_index)
    propagate_flash(octopuses, row_index - 1, col_index + 1)
    propagate_flash(octopuses, row_index + 1, col_index - 1)
    propagate_flash(octopuses, row_index + 1, col_index)
    propagate_flash(octopuses, row_index + 1, col_index + 1)
    propagate_flash(octopuses, row_index, col_index - 1)
    propagate_flash(octopuses, row_index, col_index + 1)
  end
end

def flash(octopuses)
  octopuses.each.with_index do |row, row_index|
    row.each.with_index do |octopus, col_index|
      propagate_flash(octopuses, row_index, col_index, false)
    end
  end

  reset(octopuses)
end

def print_octopuses(octopuses)
  puts octopuses.map { |row| row.map(&:energy).join('') }.join("\n")
  puts "***"
end

octopuses = File.
  readlines(ARGV[0] || './input').
  map { |s| s.chomp.split(//).map { |x| Octopus.new(Integer(x)) } }

400.times do |i|
  octopuses = increase_energy(octopuses)
  octopuses = flash(octopuses)
  if octopuses.all? { |row| row.all? { |o| o.energy == 0 } }
    puts i + 1
  end
  # print_octopuses(octopuses)
end
