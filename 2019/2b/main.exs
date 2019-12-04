defmodule Computer do
  def run(state, noun, verb) do
    modified_state = state |> replace(1, noun) |> replace(2, verb)
    compute(modified_state, 0) |> Enum.at(0)
  end

  def compute(state, position) do
    case Enum.at(state, position) do
      1 ->
        Computer.compute(compute_sum(state, position), position + 4)

      2 ->
        Computer.compute(compute_multiplication(state, position), position + 4)

      99 ->
        state
    end
  end

  defp compute_sum(state, position) do
    value =
      Enum.at(state, Enum.at(state, position + 1)) + Enum.at(state, Enum.at(state, position + 2))

    replace(state, Enum.at(state, position + 3), value)
  end

  defp compute_multiplication(state, position) do
    value =
      Enum.at(state, Enum.at(state, position + 1)) * Enum.at(state, Enum.at(state, position + 2))

    replace(state, Enum.at(state, position + 3), value)
  end

  defp replace(state, position, new_value) do
    Enum.with_index(state)
    |> Enum.map(fn {value, index} -> if index == position, do: new_value, else: value end)
  end
end

{:ok, input} = System.argv() |> List.first() |> File.read()
state = String.split(String.trim_trailing(input, "\n"), ",") |> Enum.map(&String.to_integer/1)
inits = Enum.flat_map(0..99, fn noun -> Enum.map(0..99, fn verb -> {noun, verb} end) end)

{noun, verb} =
  Enum.find(inits, fn {noun, verb} -> Computer.run(state, noun, verb) == 19_690_720 end)

IO.puts(100 * noun + verb)
