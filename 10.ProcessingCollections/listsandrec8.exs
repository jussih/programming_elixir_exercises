defmodule Tax do
  @tax_rates [NC: 0.075, TX: 0.08]
  @orders [
    [id: 123, ship_to: :NC, net_amount: 100.00],
    [id: 124, ship_to: :OK, net_amount:  35.50],
    [id: 125, ship_to: :TX, net_amount:  24.00],
    [id: 126, ship_to: :TX, net_amount:  44.80],
    [id: 127, ship_to: :NC, net_amount:  25.00],
    [id: 128, ship_to: :MA, net_amount:  10.00],
    [id: 129, ship_to: :CA, net_amount: 102.00],
    [id: 130, ship_to: :NC, net_amount:  50.00],
  ]

  def add_tax(orders, taxes) do
    for order <- orders do
      Enum.into([total_amount: calculate_total(Keyword.get(order, :net_amount), Keyword.get(order, :ship_to), taxes)], order)
    end
  end

  defp calculate_total(amount, ship_to, taxes), do: amount + amount * Keyword.get(taxes, ship_to, 0)
  
  def run(), do: add_tax(@orders, @tax_rates)
end
