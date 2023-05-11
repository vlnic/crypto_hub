defmodule CryptoHub.Authenticate.AuthenticateByLoginCommand do
  alias CryptoHub.Encryption.Hash
  alias CryptoHub.User

  require Logger

  def execute(login, password) do
    with {:ok, %User{password: hashed} = user} <- User.by_login(login),
         {:ok, :pass} <- Hash.verify(password, hashed)
    do
      {:ok, user}
    else
      {:error, :user_not_found} ->
        Logger.debug("authenticate error with reason: user_not_found")
        {:error, :incorrect_login_or_password}

      {:error, :invalid_password} ->
        Logger.debug("authenticate error with reason: invalid_password")
        {:error, :incorrect_login_or_password}
    end
  end
end
