defmodule CryptoHub.Commands.CreateAccountCommand do
  alias CryptoHub.{Account, User}
  alias CryptoHub.Platform
  alias CryptoHub.Repo

  def execute(%User{id: user_id}, platform, credentials \\ %{}) do
    with :ok <- ensure_platform(platform) do
      %Account{user_id: user_id}
      |> Account.changeset(%{
        platform: platform,
        credentials: credentials
      })
      |> Repo.insert()
    end
  end

  defp ensure_platform(platform) do
    if Enum.member?(Platform.available_platforms(), platform) do
      :ok
    else
      {:error, :undefined_platform}
    end
  end
end
