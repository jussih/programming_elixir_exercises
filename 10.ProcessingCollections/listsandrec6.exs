defmodule MyEnum do
  def flatten(list), do: do_flatten(list)
  defp do_flatten([]), do: []
  defp do_flatten([head | tail]) when is_list(head), do: do_flatten(head) ++ do_flatten(tail)  # slow
  defp do_flatten([head | tail]), do: [head | do_flatten(tail)]
end
