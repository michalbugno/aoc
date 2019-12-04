defmodule Computer do
  def run(state) do
    init_state = state |> replace(1, 12) |> replace(2, 2)
    compute(init_state, 0)
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
new_state = Computer.run(state)

IO.puts(Enum.at(new_state, 0))
