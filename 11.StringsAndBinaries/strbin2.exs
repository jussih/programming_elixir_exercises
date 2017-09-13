defmodule Str do
  def anagram?(word1, word2) do
    Map.equal?(count_letters(word1), count_letters(word2))
  end
  defp count_letters(word) do
    Enum.reduce(word, Map.new(), fn letter, map -> Map.update(map, letter, 1, fn n -> n + 1 end) end)
  end

  def anagram2?(word1, word2) do
    Enum.sort(word1) == Enum.sort(word2)
  end
end
