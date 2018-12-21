defmodule Dictionary do
  def random_word do
    word_list()
    |> Enum.random()
  end

  def word_list do
    "../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  def words_of_length(length) do
    word_list()
    |> Enum.filter(fn word -> String.length(word) == length end)
  end
end
