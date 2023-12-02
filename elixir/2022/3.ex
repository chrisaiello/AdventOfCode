defmodule AOC do
  def aoc_3_1 do
    File.read!("./3_test.txt")
    |> String.split("\n")
    |> chunck_sacks
    |> Enum.map(&find_duplicate/1)
    |> Enum.map(&priority/1)
    |> Enum.sum
  end

  def aoc_3_2 do
    File.read!("./3.txt")
    |> String.split("\n")
    |> Enum.chunk_every(3)
    |> Enum.map(&find_team/1)
    |> Enum.map(&priority/1)
    |> Enum.sum
    |> IO.inspect
  end

  def find_team(team) do
    [e1,e2,e3] = Enum.map(team, &String.codepoints/1)
    Enum.find(e1, fn x -> Enum.member?(e2, x) and Enum.member?(e3, x) end)
  end

  def chunck_sacks(sacks) do
       Enum.map(sacks, &String.codepoints/1)
    |> Enum.map(fn x -> Enum.chunk_every(x, div(length(x),2)) end)
  end

  def find_duplicate([h1, h2] = _sack) do
    Enum.find(h1, fn x -> Enum.member?(h2, x) end)
  end

  def priority(item) do
    cond do
      item == String.upcase(item) ->
        (:binary.first item) - 38
      true ->
        (:binary.first item) - 96
    end
  end

end

AOC.aoc_3_2
 