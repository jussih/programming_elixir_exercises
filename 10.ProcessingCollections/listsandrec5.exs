defmodule MyEnum do
  def all?([], _fun), do: false
  def all?(list, fun) do
    reduce(list, true, fn head, acc -> fun.(head) and acc end)
  end
  def all?([]), do: false
  def all?(list) do
    reduce(list, true, fn head, acc -> head && acc end)
  end

  def each([], _), do: :ok
  def each([head | tail], fun) do
    fun.(head)
    each(tail, fun)
  end

  def filter([], _), do: []
  def filter([head | tail], fun) do
    if fun.(head) do
      [head | filter(tail, fun)]
    else
      filter(tail, fun)
    end
  end

  def split(list, pos) do  # O(n^2)
    do_split(list, pos, {[], []})
  end
  defp do_split([head | tail], 1, {first, _second}), do: {first ++ [head], tail}
  defp do_split([head | tail], counter, {first, second}) do
    do_split(tail, counter - 1, {first ++ [head], second})
  end

  def split2(list, pos) when pos >= 0, do: do_split2(list, pos)  # O(n)
  defp do_split2([], _), do: {[], []}
  defp do_split2(list, 0), do: {[], list}
  defp do_split2([head | tail], 1), do: {[head], tail}
  defp do_split2([head | tail], counter) do
    {first, second} = do_split2(tail, counter - 1)
    {[head | first], second}
  end

  def take(list, count), do: do_take(list, count)
  defp do_take([], _count), do: []
  defp do_take(_list, 0), do: []
  defp do_take([head | _tail], 1), do: [head]
  defp do_take([head | tail], count), do: [head | do_take(tail, count - 1)]

  defp map([], _), do: []
  defp map([head | tail], fun), do: [fun.(head)|map(tail)]

  defp reduce([], acc, _), do: acc
  defp reduce([head | tail], acc, fun) do
    reduce(tail, fun.(head, acc), fun)
  end
end
