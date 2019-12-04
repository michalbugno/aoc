defmodule Fuel do
  def count(number) do
    required = div(number, 3) - 2

    if required <= 0 do
      0
    else
      required + Fuel.count(required)
    end
  end
end

File.stream!(List.first(System.argv()))
|> Stream.map(&String.trim(&1, "\n"))
|> Stream.map(&String.to_integer/1)
|> Stream.map(&Fuel.count/1)
|> Enum.sum()
|> IO.puts()
