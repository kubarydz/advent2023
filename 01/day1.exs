defmodule Day1 do
  def load do
    {:ok, testInput} = File.read("test")
    part1(testInput)
    {:ok, input} = File.read("input")
    part1(input)
  end

  defp part1(input) do
    result =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.replace(&1, ~r/[^\d]/, ""))
      |> Enum.map(&firstLastCombine(&1))
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()

    IO.puts(result)
  end

  defp firstLastCombine(str) do
    first = String.first(str)
    last = String.last(str)
    "#{first}#{last}"
  end
end

Day1.load()
