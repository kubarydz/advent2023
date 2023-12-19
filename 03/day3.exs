defmodule Day3 do
  def load do
    testInput = File.read!("test")
    part1(testInput)
    part2(testInput)
    input = File.read!("input")
    part1(input)
    part2(input)
  end

  defp get_lines(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
  end

  defp get_nums(lines) do
    lines
    |> Enum.flat_map(fn {line, i} ->
      Regex.scan(~r/\d+/, line, return: :index)
      |> List.flatten()
      |> Enum.map(fn {j, len} ->
        {(i - 1)..(i + 1)//1, (j - 1)..(j + len)//1,
         String.to_integer(String.slice(line, j, len))}
      end)
    end)
  end

  defp part1(input) do
    lines = get_lines(input)
    nums = get_nums(lines)

    symbols =
      lines
      |> Enum.flat_map(fn {line, i} ->
        Regex.scan(~r/[^0-9.]/, line, return: :index)
        |> List.flatten()
        |> Enum.map(fn {j, _} ->
          {i, j}
        end)
      end)

    res =
      nums
      |> Enum.filter(fn {row, col, _} ->
        for i <- row,
            j <- col,
            reduce: false,
            do: (acc -> acc || {i, j} in symbols)
      end)
      |> Enum.map(&elem(&1, 2))
      |> Enum.sum()

    IO.puts(res)
  end

  defp part2(input) do
    lines = get_lines(input)
    nums = get_nums(lines)

    res =
      input
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.flat_map(fn {line, i} ->
        Regex.scan(~r/\*/, line, return: :index)
        |> List.flatten()
        |> Enum.map(fn {j, _} -> {i, j} end)
      end)
      |> Enum.map(fn {i, j} ->
        case Enum.filter(nums, fn {row, col, _} -> i in row and j in col end) do
          [a, b] -> elem(a, 2) * elem(b, 2)
          _ -> 0
        end
      end)
      |> Enum.sum()

    IO.puts(res)
  end
end

Day3.load()
