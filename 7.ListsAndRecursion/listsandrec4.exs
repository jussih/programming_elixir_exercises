defmodule MyList do
  def span(from, to) when from > to, do: nil
  def span(from, to) when from == to, do: [to]
  def span(from, to), do: [from | span(from + 1, to)]
end
