defmodule AOC do
  def aoc_4 do
    File.read!("./4.txt")
    |> String.split("\n")
    |> Enum.map(fn x -> String.split(x, ",") end )
    |> Enum.map(fn x -> parse_schedules(x) end)
    |> Enum.count(fn x -> x==true end)
    |> IO.inspect
  end

  def parse_schedules([range1,range2]) do
    elf1 = create_schedule_map(range1)
    elf2 = create_schedule_map(range2)

    # Does one schedule fully contain the other?


    part_2(elf1, elf2)

  end

  def create_schedule_map(range) do
    i = fn x ->
      Enum.map(x,
        fn x -> String.to_integer(x)
      end)
    end

    [start, end_] = i.(String.split(range, "-"))
    %{start: start, end: end_}
  end

  def part_1(elf1, elf2) do
    # Does one schedule fully contain the other?
    (elf1.start <= elf2.start and elf1.end >= elf2.end)
    or
    (elf2.start <= elf1.start and elf2.end >= elf1.end)
  end

  def part_2(elf1, elf2) do
    # Do schedules overlap either completely or partially?
    # Inverse of "is each schedule completely independant?"
    result =
    (elf1.start < elf2.start and elf1.end < elf2.start)
    or
    (elf2.start < elf1.start and elf2.end < elf1.start)
    not result
  end

end

AOC.aoc_4
