defmodule CryptoHub.Platforms.Binance.BinanceSessionSup do
  use Supervisor

  alias CryptoHub.Account
  alias CryptoHub.Platform.Binance.SessionRegistry
  alias CryptoHub.Platforms.Binance

  require Logger

  def start_link(opts \\ []) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(init_arg \\ []) do
    chlidren = [
      session_spec()
    ]

    Supervisor.init(chlidren, strategy: :one_for_one)
  end

  def start_session(%Account{platform: platform} = account) do
    account
    |> Binance.child_spec()
    |> start_child()
  end

  def session_spec do
    %{
      start: {Registry, :start_link, [[
        keys: :unique,
        name: SessionRegistry,
        partitions: System.schedulers_online()
      ]]},
      id: :binance_sessions
    }
  end

  def start_child(child_spec) do
    case Supervisor.start_child(__MODULE__, child_spec) do
      {:ok, pid} ->
        {:ok, pid}

      {:error, :already_present} ->
        Logger.debug("child already present, restart_child: #{inspect child_spec}")
        case Supervisor.delete_child(__MODULE__, child_spec.id) do
          :ok -> start_child(child_spec)
          error ->
            Logger.error("BinanceSessionSup.start_child error restarting child: #{inspect error}")
            error
        end

      {:error, {:already_started, pid}} ->
        {:ok, pid}

      {:error, {{:failed_to_start, error}, child_spec}} ->
        Logger.error("BinanceSessionSup.start_child #{inspect child_spec} child init failed: #{inspect error}")
        error

      error ->
        Logger.error("BinanceSessionSup.start_child error starting child: #{inspect error}")
        error
    end
  end
end
