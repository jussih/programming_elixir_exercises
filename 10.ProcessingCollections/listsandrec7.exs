defmodule MyPrimes do

  def span(from, to) when from > to, do: nil
  def span(from, to) when from == to, do: [to]
  def span(from, to), do: [from | span(from + 1, to)]

  def is_prime(1), do: true
  def is_prime(2), do: true
  def is_prime(x) do
    not Enum.reduce(2..x-1, false, fn n, divisible -> rem(x, n) == 0 or divisible end)
  end

  def primes(n) do
    for x <- 2..n, is_prime(x), do: x
  end
end
