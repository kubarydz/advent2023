defmodule Day1 do
  def load do
    {:ok, testInput} = File.read("test")
    part1(testInput)
    {:ok, testInput} = File.read("test2")
    part2(testInput)
    {:ok, input} = File.read("input")
    part1(input)
    part2(input)
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

  defp part2(input) do
    result =
      input
      |> mapLetters
      |> String.split("\n", trim: true)
      |> Enum.map(&String.replace(&1, ~r/[^\d]/, ""))
      |> Enum.map(&firstLastCombine(&1))
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()

    IO.puts(result)
  end

  defp mapLetters("one" <> rest), do: "1" <> mapLetters("e" <> rest)
  defp mapLetters("two" <> rest), do: "2" <> mapLetters("o" <> rest)
  defp mapLetters("three" <> rest), do: "3" <> mapLetters("e" <> rest)
  defp mapLetters("four" <> rest), do: "4" <> mapLetters(rest)
  defp mapLetters("five" <> rest), do: "5" <> mapLetters("e" <> rest)
  defp mapLetters("six" <> rest), do: "6" <> mapLetters(rest)
  defp mapLetters("seven" <> rest), do: "7" <> mapLetters("n" <> rest)
  defp mapLetters("eight" <> rest), do: "8" <> mapLetters("t" <> rest)
  defp mapLetters("nine" <> rest), do: "9" <> mapLetters("e" <> rest)
  defp mapLetters(<<char, rest::binary>>), do: <<char>> <> mapLetters(rest)
  defp mapLetters(""), do: ""

  #  defp mapLetters1(str) do
  #    str
  #    |> String.replace(~r/one/, "1" <> "e")
  #    |> String.replace(~r/two/, "2" <> "o")
  #    |> String.replace(~r/three/, "3" <> "e")
  #    |> String.replace(~r/four/, "4")
  #    |> String.replace(~r/five/, "5" <> "e")
  #    |> String.replace(~r/six/, "6")
  #    |> String.replace(~r/seven/, "7" <> "n")
  #    |> String.replace(~r/eight/, "8" <> "t")
  #    |> String.replace(~r/nine/, "9")
  #  end

  defp firstLastCombine(str) do
    first = String.first(str)
    last = String.last(str)
    "#{first}#{last}"
  end
end

Day1.load()
