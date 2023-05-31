defmodule CryptoHub.Commands.StartAccountProcessesCommand do
  alias CryptoHub.Account
  alias CryptoHub.Platforms.Binance.BinanceSessionSup

  def execute(user) do
    user
    |> Account.by_user(user)
    |> Enum.each(&start_session/1)
  end

  defp start_session(%Account{platform: "binance"} = account) do
    BinanceSessionSup.start_session(account)
  end
  defp start_session(_), do: :skip
end
