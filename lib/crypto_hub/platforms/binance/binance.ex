defmodule CryptoHub.Platforms.Binance do
  use GenServer

  alias CryptoHub.Account
  alias CryptoHub.Platforms.Binance.{
    BinanceSessionSup,
    SessionRegistry
  }

  @behaviour CryptoHub.Platform

  @update_state_timeout 1800

  defmodule State do
    defstruct [
      account: nil,
      account_info: %{},
      wallet_list: []
    ]
  end

  def start_link(account) do
    GenServer.start_link(__MODULE__, [account], name: via_tuple(huid, udid))
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

      {pid, _value} ->
        {:ok, pid}
    end
  end

  def account_info(any) do

  end

  def coin_average_price() do

  end

  def wallet_list() do

  end

  def wallet_info(wallet_id) do
  end

  def handle_continue(:fetch_account_info, state) do
    
  end
end
