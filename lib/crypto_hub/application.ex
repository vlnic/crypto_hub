defmodule CryptoHub.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      CryptoHubWeb.Telemetry,
      # Start the Ecto repository
      CryptoHub.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: CryptoHub.PubSub},
      # Start Finch
      {Finch, name: CryptoHub.Finch},
      # Start the Endpoint (http/https)
      CryptoHubWeb.Endpoint
      # Start a worker by calling: CryptoHub.Worker.start_link(arg)
      # {CryptoHub.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CryptoHub.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CryptoHubWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
