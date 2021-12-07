file = File.open('./input')
current = Integer(file.readline)
increases = 0

while !file.eof?
  line = file.readline
  value = Integer(line)
  if value > current
    increases += 1
  end

  current = value
end

puts increases
