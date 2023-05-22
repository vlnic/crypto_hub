defmodule CryptoHub.Platform do
  alias CryptoHub.Account

  @type account :: Account
  @type pair_code :: binary()

  @callback account_info() :: {:ok, term()} | {:error, term()}

  @callback pair_avg_price(pair_code) :: {:ok, term()} | {:error, term()}

  @callback wallet_list() :: {:ok, list()} | {:error, term()}

  @callback wallet_info(wallet_id :: term()) :: {:ok, term()} | {:error, term()}
end
