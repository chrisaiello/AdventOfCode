defmodule AOC do
  def aoc_1 do
    File.read!("./1.txt")
    |> String.split("\n")
    |> Enum.map(fn x -> parse_calories(x) end)
    |> calc_cals()
  end

  def parse_calories(line) do
    case Integer.parse(line) do
      :error -> nil
      {num, ""} -> num
    end
  end

  defp calc_cals(list) do
    chunks = Enum.chunk_by(list, &(&1 == nil))
    (for x <- chunks, x != [nil], do: Enum.sum(x))
    |> Enum.sort()
    |> Enum.take(-3)
    |> IO.inspect
    |> Enum.sum()
    |> IO.inspect
  end
end

AOC.aoc_1
