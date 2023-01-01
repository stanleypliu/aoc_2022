defmodule DayFiveExercise do
  import Helpers

  @starting_state %{
    1 => ["R", "P", "C", "D", "B", "G"],
    2 => ["H", "V", "G"],
    3 => ["N", "S", "D", "Q", "J", "P", "M"],
    4 => ["P", "S", "L", "G", "D", "C", "N", "M"],
    5 => ["J", "B", "N", "C", "P", "F", "L", "S"],
    6 => ["Q", "B", "D", "Z", "V", "G", "T", "S"],
    7 => ["B", "Z", "M", "H", "F", "T", "Q"],
    8 => ["C", "M", "D", "B", "F"],
    9 => ["F", "C", "Q", "G"]
  }

  def convert_string_to_int(map) do
    for {k, v} <- map, into: %{}, do: {k, String.to_integer(v)}
  end

  # Each of these stacks needs to implement the following behaviours:
  # - when moving crates to another stack, the first crate is taken from the top,
  # successive crates are taken after
  # - when adding crates, the first one to be taken from another stack is added first
  # followed by the other crates in order
  def answer_one(file) do
    instructions = parse_instructions(file)

    final_state =
      Enum.reduce(instructions, @starting_state, fn instruction, acc ->
        amount = Map.get(instruction, "amount")

        source = Map.get(instruction, "source")

        crates_at_source = Map.get(acc, source)

        {new_crates_at_source, removed_crates} = crates_at_source |> Enum.split(amount * -1)

        destination = Map.get(instruction, "destination")

        new_crates_at_destination =
          Map.get(acc, destination) |> Enum.concat(removed_crates |> Enum.reverse())

        Map.put(acc, source, new_crates_at_source)
        |> Map.put(destination, new_crates_at_destination)
      end)

    Map.values(final_state) |> Enum.map(&List.last/1) |> Enum.join()
  end

  def answer_two(file) do
    instructions = parse_instructions(file)

    final_state =
      Enum.reduce(instructions, @starting_state, fn instruction, acc ->
        amount = Map.get(instruction, "amount")

        source = Map.get(instruction, "source")

        crates_at_source = Map.get(acc, source)

        {new_crates_at_source, removed_crates} = crates_at_source |> Enum.split(amount * -1)

        destination = Map.get(instruction, "destination")

        new_crates_at_destination = Map.get(acc, destination) |> Enum.concat(removed_crates)

        Map.put(acc, source, new_crates_at_source)
        |> Map.put(destination, new_crates_at_destination)
      end)

    Map.values(final_state) |> Enum.map(&List.last/1) |> Enum.join()
  end

  def parse_instructions(file) do
    read_file(file)
    |> String.split("\n", trim: true)
    |> Enum.map(fn instruction ->
      Regex.named_captures(
        ~r/[[:alpha:][:blank:]]+(?<amount>\d+)[[:alpha:][:blank:]]+(?<source>\d)[[:alpha:][:blank:]]+(?<destination>\d)/,
        instruction
      )
      |> convert_string_to_int()
    end)
  end
end
