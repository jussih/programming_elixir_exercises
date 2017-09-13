defmodule Chop do
  def guess(actual, range_low..range_high) do
    try_guess(actual, range_low, range_high, midpoint(range_low, range_high)) 
  end
  def midpoint(low, high) do
    div(high - low, 2) + low
  end
  def try_guess(actual, low, high, guess) when guess == actual do
    print_guess(guess)
    actual
  end
  def try_guess(actual, low, high, guess) when guess < actual do
    print_guess(guess)
    try_guess(actual, guess + 1, high, midpoint(guess + 1, high))
  end
  def try_guess(actual, low, high, guess) when guess > actual do
    print_guess(guess)
    try_guess(actual, low, guess - 1, midpoint(low, guess - 1))
  end
  def print_guess(guess), do: IO.puts("Is it #{guess}")
end
