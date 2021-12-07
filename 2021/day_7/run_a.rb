values = File.read(ARGV[0] || './input').split(',').map { |x| Integer(x) }

values.sort!
median = if values.size % 2 == 0
           (values[values.size / 2 - 1] + values[values.size / 2]) / 2
         else
           values[values.size / 2]
         end

puts values.sum { |value| (value - median).abs }
