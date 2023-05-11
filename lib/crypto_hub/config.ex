defmodule CryptoHub.Config do
  def get(key, default \\ nil) do
    Application.get_env(:crypto_hub, key, default)
  end
end
