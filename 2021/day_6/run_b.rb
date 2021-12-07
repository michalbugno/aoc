fish = File.read(ARGV[0] || './input').split(',').map { |s| Integer(s) }

$cache = {}

def lanternfish_after(initial, steps)
  return 1 if steps == 0
  return lanternfish_after(8, steps - 1) + lanternfish_after(6, steps - 1) if initial == 0

  key = [initial - 1, steps - 1]
  if $cache.key?(key)
    $cache[key]
  else
    out = lanternfish_after(initial - 1, steps - 1)
    $cache[key] = out
  end
end

days = 256

out = [
  lanternfish_after(3, days),
  lanternfish_after(4, days),
  lanternfish_after(3, days),
  lanternfish_after(1, days),
  lanternfish_after(2, days),
]

puts fish.sum { |x| lanternfish_after(x, days) }
