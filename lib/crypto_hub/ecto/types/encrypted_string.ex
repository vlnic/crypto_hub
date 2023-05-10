defmodule CryptoHub.Ecto.Types.EncryptedString do
  use Ecto.Type

  def type, do: :string

  def cast(term) when is_binary(term) do
    {:ok, term}
  end
  def cast(_), do: :error

  def load(nil), do: {:ok, nil}
  def load(str) when is_binary(str) do
    encrypted = encrypt(str)
    {:ok, encrypted}
  end
  def load(_), do: :error

  def dump(nil), do: :error
  def dump(term) when is_binary(term) do
    decrypt(term)
  end
  def dump(_), do: :error

  defp encrypt(msg) do
    nonce = make_nonce()
    ct = :enacl.secretbox(msg, nonce, secret_key_base())
    Base.encode64(nonce <> ct)
  end

  defp decrypt(nonce_and_ct) do
    <<nonce :: binary-size(24), ct :: binary>> = Base.decode64!(nonce_and_ct)
    :enacl.secretbox_open(ct, nonce, secret_key_base())
  end

  defp secret_key_base do
    :secret_key_base
    |> CryptoHubWeb.Endpoint.config()
    |> hash_password()
  end

  defp make_nonce do
    :enacl.randombytes(24)
  end

  def hash_password(password) do
    <<hashed_password :: binary-size(32), _ :: binary>> = :enacl.hash(password)
    hashed_password
  end
end
