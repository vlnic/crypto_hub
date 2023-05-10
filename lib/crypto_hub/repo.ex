defmodule CryptoHub.Repo do
  use Ecto.Repo,
    otp_app: :crypto_hub,
    adapter: Ecto.Adapters.Postgres
end
