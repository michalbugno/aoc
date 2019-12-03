File.stream!(List.first(System.argv()))
|> Stream.map(&(String.trim(&1, "\n")))
|> Stream.map(&String.to_integer/1)
|> Stream.map(&(div(&1, 3) - 2))
|> Enum.sum
|> IO.puts
