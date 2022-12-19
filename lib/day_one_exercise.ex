defmodule DayOneExercise do
  import Helpers

  @spec find_most_calories(
          binary
          | maybe_improper_list(
              binary | maybe_improper_list(any, binary | []) | char,
              binary | []
            )
        ) :: any
  def find_most_calories(file) do
    read_file(file)
    |> String.split("\n")
    |> Enum.chunk_by(&(&1 == ""))
    |> Enum.filter(&(&1 != [""]))
    |> Enum.map(fn x ->
      Enum.map(x, &String.to_integer/1)
      |> Enum.reduce(fn y, acc -> y + acc end)
    end)
    |> Enum.with_index(fn elem, index -> {index, elem} end)
    |> Enum.max_by(&elem(&1, 1))
    |> elem(1)
  end

  @spec sum_of_top_three_calories(
          binary
          | maybe_improper_list(
              binary | maybe_improper_list(any, binary | []) | char,
              binary | []
            )
        ) :: number
  def sum_of_top_three_calories(file) do
    read_file(file)
    |> String.split("\n")
    |> Enum.chunk_by(&(&1 == ""))
    |> Enum.filter(&(&1 != [""]))
    |> Enum.map(fn x ->
      Enum.map(x, &String.to_integer/1)
      |> Enum.reduce(fn y, acc -> y + acc end)
    end)
    |> List.flatten()
    |> Enum.sort(&(&1 >= &2))
    |> Enum.take(3)
    |> Enum.sum()
  end
end
