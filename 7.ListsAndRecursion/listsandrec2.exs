defmodule MyList do
  def max([]), do: nil
  def max([head|tail]), do: _max([head|tail], head)
  defp _max([], current_max), do: current_max
  defp _max([head|tail], current_max) when head > current_max, do: _max(tail, head) 
  defp _max([_head|tail], current_max), do: _max(tail, current_max) 
end
