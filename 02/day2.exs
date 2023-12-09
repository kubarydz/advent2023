defmodule Day2 do
  def load do
    {:ok, testInput} = File.read("test")
    part1(testInput)
    part2(testInput)
    {:ok, input} = File.read("input")
    part1(input)
    part2(input)
  end

  defp part1(input) do
    result =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&getIdIfPossible/1)
      |> Enum.sum()

    IO.puts(result)
  end

  defp getIdIfPossible(line) do
    id = getIdFromLine(line)
    blue = getCubeCount(line, ~r/\d+ blue/)
    green = getCubeCount(line, ~r/\d+ green/)
    red = getCubeCount(line, ~r/\d+ red/)

    if blue > 14 || green > 13 || red > 12 do
      0
    else
      id
    end
  end

  defp getCubeCount(line, reg) do
    Regex.scan(reg, line)
    |> Enum.map(&hd/1)
    |> Enum.map(&String.split(&1, " "))
    |> Enum.map(&hd/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.max()
  end

  defp getIdFromLine(line) do
    parts = String.split(line, ":")
    String.to_integer(String.replace(hd(parts), ~r/[^\d]/, ""))
  end

  defp part2(input) do
    result =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&getCubePower/1)
      |> Enum.sum()

    IO.puts(result)
  end

  defp getCubePower(line) do
    blue = getCubeCount(line, ~r/\d+ blue/)
    green = getCubeCount(line, ~r/\d+ green/)
    red = getCubeCount(line, ~r/\d+ red/)

    blue * green * red
  end
end

Day2.load()
