defmodule CryptoHub.Types.OrderParams.StopLoss do
  use Construct do
    field :quantity, :integer
    field :stop_price, :integer
    field :trailing_delta, :integer
  end

  def cast(t) when is_map(t) or is_struct(t) do
    make(t)
  end
  def cast(_), do: {:error, :invalid_stop_loss_params}
end
