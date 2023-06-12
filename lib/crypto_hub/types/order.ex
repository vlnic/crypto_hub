defmodule CryptoHub.Types.Order do
  alias CryptoHub.Types.OrderType
  alias CryptoHub.Types.OrderParams.{Limit, Market, StopLoss}

  use Construct

  structure do
    field :buy_symbol, :string
    field :sell_symbol, :string
    field :side, {:array, :string}
    field :type, OrderType
    field :limit_params, Limit, default: nil
    field :market_params, Market, default: nil
    field :stop_loss_params, StopLoss, default: nil
  end
end
