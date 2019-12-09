defmodule Operation do
  defstruct type: nil, modes: []

  def parse(input) do
    type = parse_type(input)
    %Operation{type: type, modes: parse_modes(type, input)}
  end

  defp parse_type(input) do
    input |> String.pad_leading(2, "0") |> String.slice(-2..-1)
  end

  defp parse_modes(type, input) do
    modes = input |> String.pad_leading(2, "0") |> String.slice(0..-3)

    case type do
      "01" -> String.pad_leading(modes, 2, "0") |> String.graphemes()
      "02" -> String.pad_leading(modes, 2, "0") |> String.graphemes()
      "04" -> String.pad_leading(modes, 2, "0") |> String.graphemes()
      _ -> []
    end
  end
end

defmodule Computer do
  def run(state, input) do
    compute(state, 0, input)
  end

  def compute(state, position, input) do
    operation = Operation.parse(Enum.at(state, position) |> Integer.to_string())
    # IO.inspect(operation)
    # IO.inspect(state)
    # IO.inspect(position)

    case operation.type do
      "01" ->
        Computer.compute(compute_sum(state, position, operation.modes), position + 4, input)

      "02" ->
        Computer.compute(
          compute_multiplication(state, position, operation.modes),
          position + 4,
          input
        )

      "03" ->
        Computer.compute(
          compute_input(state, position, operation.modes, input.()),
          position + 2,
          input
        )

      "04" ->
        Computer.compute(compute_output(state, position, operation.modes), position + 2, input)

      "99" ->
        state
    end
  end

  defp compute_sum(state, position, modes) do
    left_in =
      if Enum.at(modes, -1) == "0" do
        Enum.at(state, Enum.at(state, position + 1))
      else
        Enum.at(state, position + 1)
      end

    right_in =
      if Enum.at(modes, -2) == "0" do
        Enum.at(state, Enum.at(state, position + 2))
      else
        Enum.at(state, position + 2)
      end

    replace(state, Enum.at(state, position + 3), left_in + right_in)
  end

  defp compute_multiplication(state, position, modes) do
    left_in =
      if Enum.at(modes, -1) == "0" do
        Enum.at(state, Enum.at(state, position + 1))
      else
        Enum.at(state, position + 1)
      end

    right_in =
      if Enum.at(modes, -2) == "0" do
        Enum.at(state, Enum.at(state, position + 2))
      else
        Enum.at(state, position + 2)
      end

    replace(state, Enum.at(state, position + 3), left_in * right_in)
  end

  def compute_input(state, position, _modes, value) do
    new_position = Enum.at(state, position + 1)
    replace(state, new_position, value)
  end

  def compute_output(state, position, modes) do
    if Enum.at(modes, -1) == "0" do
      IO.puts(Enum.at(state, Enum.at(state, position + 1)))
    else
      IO.puts(Enum.at(state, position + 1))
    end

    state
  end

  defp replace(state, position, new_value) do
    state |> List.replace_at(position, new_value)
  end
end

{:ok, input} = System.argv() |> List.first() |> File.read()
state = String.split(String.trim_trailing(input, "\n"), ",") |> Enum.map(&String.to_integer/1)
Computer.run(state, fn -> 1 end)
