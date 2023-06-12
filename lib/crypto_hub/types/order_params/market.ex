defmodule CryptoHub.Types.OrderParams.Market do
  use Construct do
    field :quantity, :integer
    field :quote_order_qty, :integer
  end

  def cast(params) when is_map(params) or is_struct(params) do
    make(params)
  end
  def cast(_), do: {:error, :invalid_market_params}
end
