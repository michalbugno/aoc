expenses = File.readlines('./input').map { |s| Integer(s) }
stats = expenses.inject({}) { |memo, v| memo.merge(v => true) }
stats.keys.each do |k|
  if stats.key?(2020 - k)
    puts (2020 - k) * k
    break
  end
end
