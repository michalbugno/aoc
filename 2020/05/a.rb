def seat_row(seat)
  min = 0
  max = 127

  seat[0, 7].split(//).each do |letter|
    if letter == 'F'
      max = (min + max) / 2
    else
      min = (min + max) / 2 + 1
    end
  end

  min
end

def seat_column(seat)
  min = 0
  max = 7

  seat[7, 3].split(//).each do |letter|
    if letter == 'L'
      max = (min + max) / 2
    else
      min = (min + max) / 2 + 1
    end
  end

  min
end

max_seat_id = File.
  readlines(ARGV[0] || './input').
  map(&:chomp).
  map { |seat| [seat, seat_row(seat), seat_column(seat)] }.
  tap { |seats| seats.each { |seat, row, column| puts "#{seat} #{row} #{column}" } }.
  map { |_, row, column| row * 8 + column }.
  max

puts max_seat_id
