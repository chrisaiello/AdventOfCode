defmodule Day1 do

  @digit_map %{
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9"
  }

  def part1 do
    File.read!("lib/input/1.txt")
    |> String.split("\n") |> Enum.map(&parse_digits/1) |> Enum.sum
  end

  def parse_digits(x) do
    String.graphemes(x) # Split string into chars
    |> Enum.filter(fn x -> Integer.parse(x) != :error end) # Extract all digits from the string
    |> parse_first_last
  end

  def parse_first_last(x) do
    [first_digit, last_digit] = [hd(x), List.last(x)]
    String.to_integer(first_digit<>last_digit)
  end

  # --- END PART 1 --- #

  def part2 do
    File.read!("lib/input/1.txt")
    |> String.split("\n") |> Enum.map(&extract_digits/1) |> Enum.sum
  end

  def extract_digits(str) do
    String.graphemes(str) # Split string into chars
    |> Enum.reduce({[], ""}, &parse_digits/2) # [] is our accumulator to store the results. "" holds the substring we are testing
    |> elem(0) |> Enum.reverse |> parse_first_last
  end

  def parse_digits(char, {acc, current}) do
    current = current <> char # Add chars 1-by-1
    cond do
      digit_key = Enum.find( Map.keys(@digit_map), &String.contains?(current, &1) ) -> # Does current contain any of the keys in digit_map?
        {[@digit_map[digit_key] | acc], String.last(current)} # If so, add that digit to acc, and keep the last character of current to account
                                                              # for cases of overlap like sevenine
      char =~ ~r/^\d$/ -> # Capture numeric digits
        {[char | acc], ""} # Add the digit to acc, and reset current
      true -> # If no match, continue and add the next char to current
        {acc, current}
    end
  end
end
