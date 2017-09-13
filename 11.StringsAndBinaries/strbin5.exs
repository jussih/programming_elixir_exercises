defmodule Str do
  def center(list) do
    column_len = Enum.reduce(list, 0, fn word, max_len -> max(max_len, String.length(word)) end)
    Enum.each(list, fn word -> IO.puts(pad(word, column_len)) end)
  end

  def pad(str, len) do
    strlen = String.length(str)
    leftpad = div(len - strlen, 2)
    String.pad_trailing(String.pad_leading(str, leftpad + strlen), len)
  end
end
