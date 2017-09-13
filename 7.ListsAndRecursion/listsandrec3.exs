defmodule MyList do
  @adec 97
  @zdec 122
  @rot_amount @zdec - @adec + 1
  def caesar([], _), do: []
  def caesar([head|tail], n), do: [rot(head+n)|caesar(tail, n)]
  defp rot(val) when val > @zdec, do: rot(val - @rot_amount)
  defp rot(val), do: val
end
