defmodule Str do
  def is_ascii([]), do: false
  def is_ascii(list), do: do_is_ascii(list, true)
  defp do_is_ascii([], still_printable), do: still_printable 
  defp do_is_ascii([head | tail], still_printable), do: do_is_ascii(tail, still_printable and is_printable(head))
  defp is_printable(code_point), do: code_point >= ?\s and code_point <= ?~
end

