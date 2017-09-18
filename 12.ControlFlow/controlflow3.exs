defmodule OK do
  def ok!({:ok, data}) do
    data
  end
  def ok!(data) do
    raise "Not OK! Error was: #{inspect data}"
  end
end
