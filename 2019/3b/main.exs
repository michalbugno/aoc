defmodule Wires do
  def parse(wire) do
    String.split(wire, ",")
    |> Enum.map(fn elem -> String.split_at(elem, 1) end)
    |> Enum.map(fn {a, b} -> {a, String.to_integer(b)} end)
  end

  def build_path(wire1, wire2) do
    %{} |> traverse_wire(wire1, "w1") |> traverse_wire(wire2, "w2")
  end

  defp traverse_wire(map, wire, wire_name) do
    {map, _, _} =
      Enum.reduce(wire, {map, {0, 0}, 0}, fn {direction, length}, state ->
        traverse_single(state, direction, length, wire_name)
      end)

    map
  end

  defp traverse_single(state, _direction, 0, _wire_name) do
    state
  end

  defp traverse_single({map, {x, y}, distance_walked}, direction, length, wire_name) do
    new_target =
      case direction do
        "U" ->
          {x, y + 1}

        "D" ->
          {x, y - 1}

        "R" ->
          {x + 1, y}

        "L" ->
          {x - 1, y}
      end

    value = Map.get(map, new_target)

    new_map =
      if value do
        Map.put(map, new_target, Map.put_new(value, wire_name, distance_walked + 1))
      else
        Map.put(map, new_target, %{wire_name => distance_walked + 1})
      end

    traverse_single({new_map, new_target, distance_walked + 1}, direction, length - 1, wire_name)
  end
end

{:ok, input} = System.argv() |> List.first() |> File.read()
[wire1_input, wire2_input, _] = String.split(input, "\n")

wire1 = Wires.parse(wire1_input)
wire2 = Wires.parse(wire2_input)

paths = Wires.build_path(wire1, wire2)
intersections = Map.to_list(paths) |> Enum.filter(fn {_, set} -> map_size(set) > 1 end)
distances = intersections |> Enum.map(fn {_, distances} -> distances end)

min = distances |> Enum.map(fn h -> Enum.sum(Map.values(h)) end) |> Enum.min()
IO.puts(min)
