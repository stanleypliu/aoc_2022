defmodule DayFourExercise do
  import Helpers

  def count_contained_pairs(file) do
    pairs =
      read_file(file)
      |> String.split("\n", trim: true)
      |> Enum.map(fn str -> String.split(str, ",") end)

    Enum.reduce(pairs, 0, fn pair, acc ->
      first_elf = Enum.at(pair, 0) |> String.split("-") |> Enum.map(&String.to_integer/1)
      second_elf = Enum.at(pair, 1) |> String.split("-") |> Enum.map(&String.to_integer/1)

      if (Enum.at(first_elf, 0) <= Enum.at(second_elf, 0) &&
            Enum.at(first_elf, 1) >= Enum.at(second_elf, 1)) ||
           (Enum.at(second_elf, 0) <= Enum.at(first_elf, 0) &&
              Enum.at(second_elf, 1) >= Enum.at(first_elf, 1)) do
        acc + 1
      else
        acc
      end
    end)
  end

  def count_intersections(file) do
    pairs =
      read_file(file)
      |> String.split("\n", trim: true)
      |> Enum.map(fn str -> String.split(str, ",") end)

    Enum.reduce(pairs, 0, fn pair, acc ->
      first_elf =
        Enum.at(pair, 0)
        |> String.split("-")
        |> Enum.map(&String.to_integer/1)
        |> (fn integers -> Range.new(Enum.at(integers, 0), Enum.at(integers, 1)) end).()
        |> MapSet.new()

      second_elf =
        Enum.at(pair, 1)
        |> String.split("-")
        |> Enum.map(&String.to_integer/1)
        |> (fn integers -> Range.new(Enum.at(integers, 0), Enum.at(integers, 1)) end).()
        |> MapSet.new()

      intersections = MapSet.intersection(first_elf, second_elf) |> MapSet.to_list()

      if Enum.count(intersections) > 0 do
        acc + 1
      else
        acc
      end
    end)
  end
end
