expenses = File.readlines('./input').map { |s| Integer(s) }
puts expenses.
  combination(3).
  find { |a, b, c| a + b + c == 2020 }.
  yield_self { |a, b, c| a * b * c }
