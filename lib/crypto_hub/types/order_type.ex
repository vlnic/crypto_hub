defmodule CryptoHub.Types.OrderType do
  @types ~w(limit market stop_loss stop_loss_limit take_profit take_profit_limit limit_maker)

  def cast(t) when t in @types do
    {:ok, t}
  end

  def cast(_), do: {:error, :undefined_order_type}
end
