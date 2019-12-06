defmodule Counter do
  def is_valid?(number) do
    chars = Integer.to_string(number) |> String.graphemes()
    has_adjacent_without_multiple?(chars) && non_decreasing?(chars)
  end

  defp has_adjacent_without_multiple?(chars) do
    groups = build_groups(chars)
    Enum.any?(groups, fn group -> Enum.count(group) == 2 end)
  end

  defp non_decreasing?(chars) do
    Enum.sort(chars) == chars
  end

  defp build_groups(chars) do
    chunk_fun = fn element, acc ->
      if Enum.empty?(acc) do
        {:cont, [element]}
      else
        if List.last(acc) == element do
          {:cont, [element | acc]}
        else
          {:cont, Enum.reverse(acc), [element]}
        end
      end
    end

    after_fun = fn
      [] -> {:cont, []}
      acc -> {:cont, Enum.reverse(acc), []}
    end

    Enum.chunk_while(chars, [], chunk_fun, after_fun)
  end
end

[start, finish] = System.argv() |> Enum.map(&String.to_integer(&1))

count = Enum.count(start..finish, &Counter.is_valid?(&1))
IO.puts(count)
