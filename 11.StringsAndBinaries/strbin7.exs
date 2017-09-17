defmodule Tax do
  @tax_rates [NC: 0.075, TX: 0.08]

  def run(file_name) do
    get_stream(file_name)
    |> Stream.map(&parse_line/1)
    |> Stream.map(&add_tax/1)
    |> Stream.each(&IO.inspect/1)
    |> Stream.run()
  end

  defp get_stream(file_name) do
    file = File.open!(file_name, [:read, :utf8])
    IO.read(file, :line)  # consume header line
    IO.stream(file, :line)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> build_kwlist()
  end

  defp build_kwlist([id, destination, amount]),
    do: [id: String.to_integer(id), ship_to: String.to_atom(String.trim_leading(destination, ":")), net_amount: String.to_float(amount)]

  defp add_tax(order) do
    Enum.into(get_total_amount(order), order)
  end

  defp get_total_amount(order), do: [total_amount: calculate_total(Keyword.get(order, :net_amount), Keyword.get(order, :ship_to), @tax_rates)]

  defp calculate_total(amount, ship_to, taxes), do: amount + amount * Keyword.get(taxes, ship_to, 0)
end
