defmodule CryptoHub.Platform do
  alias CryptoHub.Account

  @type account :: Account
  @type pair_code :: binary()
  @type account_id :: binary() | atom()

  @callback account_info(account_id) :: {:ok, term()} | {:error, term()}

  @callback open_orders_list(account_id) :: {:ok, list()} | {:error, term()}
end
