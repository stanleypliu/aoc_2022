defmodule DayThreeExercise do
  import Helpers

  # Recursion breaks
  def reduced_list([], 27, reduced) do
    reduced
  end

  def reduced_list([], 53, reduced) do
    reduced
  end

  def reduced_list([first | rest], i, reduced) do
    reduced_list(rest, i + 1, Map.put(reduced, first, i))
  end

  def lowercase_priorities do
    list = Enum.to_list(?a..?z) |> List.to_string() |> String.codepoints()

    reduced_list(list, 1, %{})
  end

  def uppercase_priorities do
    list = Enum.to_list(?A..?Z) |> List.to_string() |> String.codepoints()

    reduced_list(list, 27, %{})
  end

  @spec calc_sum(
          binary
          | maybe_improper_list(
              binary | maybe_improper_list(any, binary | []) | char,
              binary | []
            )
        ) :: number
  def calc_sum(file) do
    read_file(file)
    |> String.split("\n", trim: true)
    |> Enum.map(fn str ->
      rucksack_contents = String.split_at(str, div(String.length(str), 2))

      first_compartment = elem(rucksack_contents, 0) |> String.codepoints() |> MapSet.new()
      second_compartment = elem(rucksack_contents, 1) |> String.codepoints() |> MapSet.new()

      common_item =
        MapSet.intersection(first_compartment, second_compartment)
        |> MapSet.to_list()
        |> List.first()

      if Map.get(lowercase_priorities(), common_item) != nil do
        Map.get(lowercase_priorities(), common_item)
      else
        Map.get(uppercase_priorities(), common_item)
      end
    end)
    |> Enum.sum()
  end

  def part_two_sum(file) do
    read_file(file)
    |> String.split("\n", trim: true)
    |> Enum.chunk_every(3)
    |> Enum.map(fn group ->
      sets = Enum.map(group, fn elf ->
        String.codepoints(elf) |> MapSet.new()
      end)

      [head | _tail] = sets

      common_item = List.foldl(sets, head, fn set, acc -> MapSet.intersection(set, acc) end)
      |> MapSet.to_list()
      |> List.first()

      if Map.get(lowercase_priorities(), common_item) != nil do
        Map.get(lowercase_priorities(), common_item)
      else
        Map.get(uppercase_priorities(), common_item)
      end
    end)
    |> Enum.sum
  end
end
