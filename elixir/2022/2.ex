defmodule AOC do
  @rock "A"
  @paper "B"
  @scissors "C"

  @shd_lose "X"
  @shd_draw "Y"
  @shd_win  "Z"



  def aoc_2 do
    File.read!("./2.txt")
    |> String.split("\n")
    |> Enum.map(fn ln -> String.at(ln, 0) <> " #{move_select(ln)}" end)
    |> Enum.map(fn ln -> ( move_score(ln) + outcome_score(ln) ) end)
    |> Enum.sum()
    |> IO.inspect

  end


  def beats(move) do
    # Think of as "move beats what", not "what beats move"
    case move do
      @rock -> @scissors
      @paper -> @rock
      @scissors -> @paper
    end
  end

  def loses_to(move) do
    # Think of as "move loses to what", not "what loses to move"
    case move do
      @rock -> @paper
      @paper -> @scissors
      @scissors -> @rock
    end
  end

  def move_select(turn) do
    [om, strat] = String.split(turn, " ")
    case strat do
      @shd_win -> loses_to(om)
      @shd_lose -> beats(om)
      @shd_draw -> om
    end


  end

  def move_score(move) do
    #IO.inspect(my_move)
    case String.at(move, 2) do
      @rock ->
        #IO.puts("Move is #{move}, score 1")
        1
      @paper ->
        #IO.puts("Move is #{move}, score 2")
        2
      @scissors ->
        #IO.puts("Move is #{move}, score 3")
        3
    end
  end

  def outcome_score(turn) do
    [om, mm] = String.split(turn," ")
    IO.puts("Outcome move is #{om <> mm}")
    cond do
      om == mm ->
        #IO.puts("#{om}==#{mm}, draw=3")
        3 # DRAW
      loses_to(mm) == om ->
        #IO.puts("#{om} beats #{mm}, loss=0")
        0 # LOSS
      beats(mm) == om ->
        #IO.puts("#{om} loses to #{mm}, win=6")
        6 # WIN
    end
  end



end



AOC.aoc_2


# func for calculate move score
# func for calculate outcome score
# Create new list, [move_score1+outcome_score1, ...]
# Sum list
# rock(1) beats scissors(3)
# paper(2) beats rock(1)
# scissors(3) beats paper(2)
# rock(65)
# paper(66)
# scissors(67)
