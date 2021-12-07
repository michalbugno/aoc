require 'pry'

class Board
  def initialize(data)
    @data = data
    rows_no = data.size
    columns_no = data[0].size

    @marks = Array.new(rows_no) { Array.new(columns_no, nil) }
  end

  def mark(number)
    @data.each.with_index do |row, row_index|
      row.each.with_index do |value, col_index|
        if value == number
          @marks[row_index][col_index] = true
        end
      end
    end
  end

  def win?
    row_win = @marks.any? { |row| row.all? { |value| !value.nil? } }
    return true if row_win

    (0..@marks[0].size - 1).any? do |col_index|
      @marks.map { |row| row[col_index] }.all? { |value| !value.nil? }
    end
  end

  def unmarked_sum
    sum = 0
    @data.each.with_index do |row, row_index|
      row.each.with_index do |value, col_index|
        if !@marks[row_index][col_index]
          sum += value
        end
      end
    end

    sum
  end
end

def parse_board(input)
  data = input.split("\n").map { |line| line.split(' ').map { |s| Integer(s) } }
  Board.new(data)
end

input = File.readlines('./input')
draws = input.shift.split(',').map { |s| Integer(s) }

input.shift

boards = input.
  join('').
  split("\n\n").
  map { |board| parse_board(board) }

won_boards = []
loop do
  number = draws.shift
  boards.each { |board| board.mark(number) }
  boards.each do |board|
    won_boards << board if board.win?
  end
  boards = boards.reject { |board| board.win? }
  if boards.empty?
    win = won_boards.last
    puts number
    puts win.unmarked_sum
    puts number * win.unmarked_sum
    break
  end
end
