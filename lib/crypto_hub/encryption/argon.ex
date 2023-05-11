defmodule CryptoHub.Encryption.Argon do
  alias Argon2
  alias CryptoHub.Encryption.Hash

  @behaviour Hash

  @impl Hash
  def hash_password(password) do
    Argon2.hash_pwd_salt(password)
  end

  @impl Hash
  def verify(password, hashed) do
    try do
      if Argon2.verify_pass(password, hashed) do
        {:ok, :pass}
      else
        {:error, :invalid}
      end
    catch
      _ ->
        {:error, :invalid}
    end
  end
end
