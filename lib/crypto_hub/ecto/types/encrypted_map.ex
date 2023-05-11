defmodule CryptoHub.Ecto.Types.EncryptedMap do
  use Ecto.Type

  alias CryptoHub.Encryption.SecretBox

  def type, do: :map

  def cast(nil), do: {:ok, nil}
  def cast(term) when is_map(term) do
    {:ok, term}
  end
  def cast(_), do: :error

  def load(nil), do: {:ok, nil}
  def load(%{}), do: {:ok, %{}}
  def load(term) when is_map(term) do
    term
    |> Jason.encode!()
    |> SecretBox.encrypt()
    |> SecretBox.to_string()
  end
  def load(term) when is_struct(term) do
    term |> Map.from_struct() |> load()
  end

  def dump(nil), do: {:ok, nil}
  def dump(%{}), do: {:ok, %{}}
  def dump(term) when is_binary(term) do
    term
    |> SecretBox.decrypt_from_base64()
    |> Jason.decode()
  end
end
