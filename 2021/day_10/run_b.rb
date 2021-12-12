def closing?(char)
  [')', '}', '>', ']'].include?(char)
end

def complement(char)
  case char
  when '[' then ']'
  when '(' then ')'
  when '<' then '>'
  when '{' then '}'
  else
    raise "AHA!"
  end
end

def matches?(start, finish)
  return finish == ')' if start == '('
  return finish == ']' if start == '['
  return finish == '>' if start == '<'
  return finish == '}' if start == '{'

  raise "#{start} #{finish}"
end

def calculate(completion)
  char_value = {')' => 1, ']' => 2, '}' => 3, '>' => 4}
  p completion

  total = 0
  completion.each do |char|
    total *= 5
    total += char_value[char]
  end

  total
end

def score(chunk, stack = [])
  if closing?(chunk[0])
    match = stack.pop
    if matches?(match, chunk[0])
      score(chunk[1 .. -1], stack)
    else
      0
    end
  else
    if chunk.empty?
      calculate(stack.reverse.map { |char| complement(char) })
    else
      stack.push(chunk[0])
      score(chunk[1 .. -1], stack)
    end
  end
end

chunks = File.readlines(ARGV[0] || './input').map(&:chomp)
scores = chunks.
  map { |chunk| score(chunk) }.
  reject { |score| score == 0 }.
  sort

puts scores[scores.size / 2]
