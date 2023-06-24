defmodule CryptoHub.Types.Order do
  alias CryptoHub.Types.OrderType
  alias CryptoHub.Types.OrderParams.{Limit}

  use Construct

  structure do
    field :buy_symbol, :string
    field :sell_symbol, :string
    field :side, {:array, :string}
    field :type, OrderType
    field :limit_params, Limit, default: nil
    field :market_params do
      field :quantity, :integer
      field :quote_order_qty, :integer
    end
    field :stop_loss_params do
      field :quantity, :integer
      field :stop_price, :integer
      field :trailing_delta, :integer
    end
  end
end
