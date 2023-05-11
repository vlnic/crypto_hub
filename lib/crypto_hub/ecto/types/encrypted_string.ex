defmodule CryptoHub.Ecto.Types.EncryptedString do
  use Ecto.Type

  alias CryptoHub.Encryption.SecretBox

  def type, do: :string

  def cast(nil), do: {:ok, nil}
  def cast(term) when is_binary(term) do
    {:ok, term}
  end
  def cast(_), do: :error

  def load(nil), do: {:ok, nil}
  def load(""), do: {:ok, ""}
  def load(str) when is_binary(str) do
    encrypted =
      str
      |> SecretBox.encrypt()
      |> SecretBox.to_string()
    {:ok, encrypted}
  end
  def load(_), do: :error

  def dump(nil), do: :error
  def dump(""), do: {:ok, ""}
  def dump(term) when is_binary(term) do
    SecretBox.decrypt_from_base64(term)
  end
  def dump(_), do: :error
end
