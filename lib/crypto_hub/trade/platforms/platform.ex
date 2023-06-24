defmodule CryptoHub.Trade.Platform do
  alias CryptoHub.Account

  @available_platforms ~w(binance)

  @type account :: Account
  @type pair_code :: binary()
  @type account_id :: binary() | atom()

  @callback account_info(account_id) :: {:ok, term()} | {:error, term()}

  @callback open_orders_list(account_id) :: {:ok, list()} | {:error, term()}

  def available_platforms, do: @available_platforms
end
