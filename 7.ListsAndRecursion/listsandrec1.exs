defmodule MyList do
  def mapsum(list, func), do: _mapsum(list, 0, func)
  defp _mapsum([], acc, _), do: acc
  defp _mapsum([head|tail], acc, func), do: _mapsum(tail, acc+func.(head), func)
end
