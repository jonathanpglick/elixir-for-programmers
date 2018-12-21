defmodule BotTextClientChooserTest do
  use ExUnit.Case
  doctest BotTextClient.Chooser
  alias BotTextClient.Chooser

  test "letter frequency map works" do
    map = Chooser.letter_frequency_map(["a", "a", "a", "b", "c", "b"])
    assert map == %{"a" => 3, "b" => 2, "c" => 1}
  end

  test "frequency map to sorted list" do
    map = %{"a" => 3, "b" => 2, "c" => 1}
    sorted = Chooser.frequency_map_to_sorted_list(map)
    assert sorted == [{"a", 3}, {"b", 2}, {"c", 1}]
  end

  test "prioritize letters" do
    letters = Chooser.prioritize_letters(["a", "ab", "abc", "abcd"])
    assert letters == [{"a", 4}, {"b", 3}, {"c", 2}, {"d", 1}]
  end

  test "prioritize letters with exclude" do
    letters = Chooser.prioritize_letters(["a", "ab", "abc", "abcd"], ["a"])
    assert letters == [{"b", 3}, {"c", 2}, {"d", 1}]
  end
end
