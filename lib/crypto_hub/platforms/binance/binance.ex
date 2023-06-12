defmodule CryptoHub.Platforms.Binance do
  use GenServer

  alias CryptoHub.Account
  alias CryptoHub.Platforms.Binance.SessionRegistry

  @behaviour CryptoHub.Platform

  @binance_v1 Application.compile_env(:crypto_hub, :binance_client, BinanceHttp.Api.SAPI.V1)
  @update_state_timeout 1800

  defmodule State do
    defstruct [
      account: nil,
      account_info: %{},
      secret_key: nil,
      api_key: nil,
      wallet_list: []
    ]
  end

  def start_link(account) do
    GenServer.start_link(__MODULE__, [account], name: via_tuple(account.id))
  end

  def init(account) do
    {:ok, %State{account: account}, {:continue, :fetch_account_info}}
  end

  def child_id(account_id) do
    "binance_session:#{account_id}"
  end

  def chlid_spec(%Account{} = account) do
    %{
      id: child_id(account.id),
      start: {__MODULE__, :start_link, [account]},
      restart: :transient
    }
  end

  def via_tuple(account_id) do
    {:via, Registry, {SessionRegistry, child_id(account_id)}}
  end

  def get_session(account_id) do
    case Registry.lookup(SessionRegistry, child_id(account_id)) do
      [] ->
        {:error, :session_not_found}

      [{pid, _value}] ->
        {:ok, pid}
    end
  end

  def account_info(account_id) do
    with {:ok, pid} <- get_session(account_id) do
      GenServer.call(pid, :account_info)
    end
  end

  def open_orders_list(account_id) do
    with {:ok, pid} <- get_session(account_id) do
      GenServer.call(pid, :open_orders_list)
    end
  end

  def handle_continue(:fetch_account_info, %{api_key: api_key, secret_key: secret} = state) do
    wallets = @binance_v1.capital_getall(%{}, api_key: api_key, secret_key: secret)
    {:noreply, %{state | wallet_list: wallets}}
  end

  def handle_call(:account_info, _from, state) do
    {:reply, state.wallet_list, state}
  end
end
