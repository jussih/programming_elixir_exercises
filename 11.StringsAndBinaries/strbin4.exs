defmodule Str do
  def calculate(string) do
    [number1, operand, number2] = Parse.split_words(string) 
    number1 = Parse.number(number1)
    number2 = Parse.number(number2)
    case operand do
      '+' -> number1 + number2
      '-' -> number1 - number2
      '*' -> number1 * number2
      '/' -> number1 / number2
      _   -> raise "Unsupported operand"
    end
  end
end

defmodule Parse do
  def number(str), do: number_digits(str, 0)
  defp number_digits([], value), do: value
  defp number_digits([digit | tail], value) when digit in '0123456789' do
    number_digits(tail, value*10 + digit - ?0)
  end
  defp number_digits([non_digit | _], _) do
    raise "Invalid digit '#{[non_digit]}'"
  end

  def pop_word(str), do: do_pop_word(str)
  defp do_pop_word([]), do: {[], []}
  defp do_pop_word([letter | tail]) when letter == ?\s do
    {[], tail}
  end
  defp do_pop_word([letter | tail]) do
    {word, remainder} = do_pop_word(tail)
    {[letter | word], remainder}
  end
  
  def split_words([]), do: []
  def split_words(str) do
    {word, remainder} = pop_word(str)
    [word | split_words(ltrim(remainder))]
  end

  def ltrim([]), do: []
  def ltrim([letter | tail]) when letter == ?\s, do: ltrim(tail)
  def ltrim(str), do: str

end

