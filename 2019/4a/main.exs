defmodule Counter do
  def is_valid?(number) do
    has_adjacent?(number) && non_decreasing?(number)
  end

  defp has_adjacent?(number) do
    s = Integer.to_string(number)
    adjacents = Enum.map(0..9, fn n -> "#{n}#{n}" end)
    Enum.any?(adjacents, fn part -> String.contains?(s, part) end)
  end

  defp non_decreasing?(number) do
    chars = Integer.to_string(number) |> String.graphemes
    Enum.sort(chars) == chars
  end
end

[start, finish] = System.argv() |> Enum.map(&String.to_integer(&1))

count = Enum.count(start..finish, &(Counter.is_valid?(&1)))
IO.puts(count)
