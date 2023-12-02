defmodule Day2 do

  @bag %{red: 12, green: 13, blue: 14}

  def run do
    input = File.read!("lib/input/2.txt")
    |> String.split("\n")
    part1(input) |> IO.inspect
    part2(input) |> IO.inspect
  end


  def part1(input) do
    input
    |> Enum.with_index(fn game, index ->
      red_valid = Regex.scan(~r/(\d+) red/, game)
      |> Enum.map(fn match ->
        [_, r] = match
        String.to_integer(r)
      end)
      |> Enum.all?(fn r -> r <= @bag.red end)

      green_valid = Regex.scan(~r/(\d+) green/, game)
      |> Enum.map(fn match ->
        [_, r] = match
        String.to_integer(r)
      end)
      |> Enum.all?(fn r -> r <= @bag.green end)

      blue_valid = Regex.scan(~r/(\d+) blue/, game)
      |> Enum.map(fn match ->
        [_, r] = match
        String.to_integer(r)
      end)
      |> Enum.all?(fn r -> r <= @bag.blue end)

      game_valid = Enum.all?([red_valid, green_valid, blue_valid])

      case game_valid do
        true -> index + 1
        false -> 0
      end
    end)
    |> Enum.sum
  end

  def part2(input) do
    input
    |> Enum.map(fn game ->
      red_max = Regex.scan(~r/(\d+) red/, game)
      |> Enum.map(fn match ->
        [_, r] = match
        String.to_integer(r)
      end)
      |> Enum.max

      green_max = Regex.scan(~r/(\d+) green/, game)
      |> Enum.map(fn match ->
        [_, r] = match
        String.to_integer(r)
      end)
      |> Enum.max


      blue_max = Regex.scan(~r/(\d+) blue/, game)
      |> Enum.map(fn match ->
        [_, r] = match
        String.to_integer(r)
      end)
      |> Enum.max

      power = red_max * green_max * blue_max

    end)
    |> Enum.sum
  end
end
