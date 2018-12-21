defmodule BotTextClient.Chooser do
  alias TextClient.State

  def choose_move(game = %State{}) do
    letter = choose_letter(game.tally)
    IO.puts("Your guess: #{letter}\n")
    %State{game | guess: letter}
  end

  def choose_letter(%{used: used, letters: letters}) do
    words_of_length = Dictionary.words_of_length(length(letters))
    [{letter_to_guess, _} | _] = prioritize_letters(words_of_length, used)
    letter_to_guess
  end

  def prioritize_letters(words) do
    prioritize_letters(words, [])
  end

  def prioritize_letters(words, exclude_letters) do
    exclude_letters_set = MapSet.new(exclude_letters)

    words
    |> Enum.flat_map(&String.graphemes(&1))
    |> Enum.filter(fn letter -> not MapSet.member?(exclude_letters_set, letter) end)
    |> letter_frequency_map()
    |> frequency_map_to_sorted_list()
  end

  def letter_frequency_map(letters) do
    letters
    |> Enum.reduce(%{}, fn letter, freq_map ->
      Map.update(freq_map, letter, 1, &(&1 + 1))
    end)
  end

  def frequency_map_to_sorted_list(freq_map) do
    freq_map
    |> Map.to_list()
    |> Enum.sort(fn {_letter_1, freq_1}, {_letter_2, freq_2} ->
      freq_1 >= freq_2
    end)
  end
end
