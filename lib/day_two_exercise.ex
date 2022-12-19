defmodule DayTwoExercise do
  import Helpers

  @own_shapes_mapping %{"X" => :rock, "Y" => :paper, "Z" => :scissors}
  @opponent_shapes_mapping %{"A" => :rock, "B" => :paper, "C" => :scissors}
  @shape_scores %{rock: 1, paper: 2, scissors: 3}

  # In terms of wins/losses for yourself
  @winning_combinations [{:rock, :scissors}, {:paper, :rock}, {:scissors, :paper}]
  @losing_combinations [{:scissors, :rock}, {:rock, :paper}, {:paper, :scissors}]

  @spec calculate_total_score(
          binary
          | maybe_improper_list(
              binary | maybe_improper_list(any, binary | []) | char,
              binary | []
            )
        ) :: number
  def calculate_total_score(file) do
    read_file(file)
    |> String.split("\n", trim: true)
    |> Enum.map(fn str ->
      scores = {String.split(str, " ") |> List.first(), String.split(str, " ") |> List.last()}

      opponent_selection = Map.get(@opponent_shapes_mapping, elem(scores, 0))
      own_selection = Map.get(@own_shapes_mapping, elem(scores, 1))

      selections = {own_selection, opponent_selection}

      if opponent_selection == own_selection do
        Map.get(@shape_scores, opponent_selection) + 3
      else
        own_score = Map.get(@shape_scores, own_selection)

        if Enum.find(@winning_combinations, fn combination -> combination == selections end) do
          own_score + 6
        else
          own_score
        end
      end
    end)
    |> Enum.sum()
  end

  @actual_second_col_mapping %{"X" => :loss, "Y" => :draw, "Z" => :win}

  @spec calculate_correct_total_score(
          binary
          | maybe_improper_list(
              binary | maybe_improper_list(any, binary | []) | char,
              binary | []
            )
        ) :: number
  def calculate_correct_total_score(file) do
    read_file(file)
    |> String.split("\n", trim: true)
    |> Enum.map(fn str ->
      scores = {String.split(str, " ") |> List.first(), String.split(str, " ") |> List.last()}

      opponent_selection = Map.get(@opponent_shapes_mapping, elem(scores, 0))
      needed_outcome = Map.get(@actual_second_col_mapping, elem(scores, 1))

      case needed_outcome do
        :loss ->
          losing_choice =
            Enum.find(@losing_combinations, fn combination ->
              opponent_selection == elem(combination, 1)
            end)

          Map.get(@shape_scores, elem(losing_choice, 0))

        :draw ->
          Map.get(@shape_scores, opponent_selection) + 3

        :win ->
          winning_choice =
            Enum.find(@winning_combinations, fn combination ->
              opponent_selection == elem(combination, 1)
            end)

          Map.get(@shape_scores, elem(winning_choice, 0)) + 6
      end
    end)
    |> Enum.sum()
  end
end
