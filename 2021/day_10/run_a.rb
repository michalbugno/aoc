def closing?(char)
  [')', '}', '>', ']'].include?(char)
end

def matches?(start, finish)
  return finish == ')' if start == '('
  return finish == ']' if start == '['
  return finish == '>' if start == '<'
  return finish == '}' if start == '{'

  raise "#{start} #{finish}"
end

def points(char)
  case char
  when ')' then 3
  when ']' then 57
  when '}' then 1197
  when '>' then 25137
  else 0
  end
end

def score(chunk, stack = [])
  if closing?(chunk[0])
    match = stack.pop
    if matches?(match, chunk[0])
      score(chunk[1 .. -1], stack)
    else
      points(chunk[0])
    end
  else
    if chunk.empty?
      0
    else
      stack.push(chunk[0])
      score(chunk[1 .. -1], stack)
    end
  end
end

chunks = File.readlines(ARGV[0] || './input').map(&:chomp)
result = chunks.sum do |chunk|
  score(chunk)
end

puts result
