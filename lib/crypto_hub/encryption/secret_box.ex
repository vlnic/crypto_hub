defmodule CryptoHub.Encryption.SecretBox do

  def encrypt(msg) do
    nonce = make_nonce()
    ct = :enacl.secretbox(msg, nonce, secret_key_base())
    {:ok, %{nonce: nonce, ct: ct}}
  end

  def to_string(%{nonce: nonce, ct: ct}) do
    Base.encode64(nonce <> ct)
  end

  def decrypt_from_base64(nonce_and_ct_64) do
    nonce_and_ct_64
    |> Base.decode64!()
    |> decrypt()
  end

  def decrypt(nonce_and_ct) do
    <<nonce :: binary-size(24), ct :: binary>> = nonce_and_ct
    :enacl.secretbox_open(ct, nonce, secret_key_base())
  end

  def secret_key_base do
    :secret_key_base
    |> CryptoHubWeb.Endpoint.config()
    |> hash_password()
  end

  def hash_password(password) do
    <<hashed_password :: binary-size(32), _ :: binary>> = :enacl.hash(password)
    hashed_password
  end

  defp make_nonce do
    :enacl.randombytes(24)
  end
end
