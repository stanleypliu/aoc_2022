defmodule DaySixExercise do
  import Helpers

  def answer_one(file, segment_length \\ 4) do
    input = read_file(file)
            |> String.replace("\n", "")
            |> String.codepoints

    Enum.reduce_while(input, %{ start: 0, end: 13 }, fn _x, acc ->
      start = Map.fetch(acc, :start) |> elem(1)
      s_end = Map.fetch(acc, :end) |> elem(1)
      segment = Enum.slice(input, start..s_end)

      if MapSet.size(MapSet.new(segment)) == segment_length do
        {:halt, Map.get(acc, :end) + 1}
      else
        {:cont, %{ start: start + 1, end: s_end + 1 }}
      end
    end)
  end

  def answer_two(file, segment_length \\ 14) do
    answer_one(file, segment_length)
  end
end
