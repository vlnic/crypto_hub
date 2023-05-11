defmodule CryptoHub.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias CryptoHub.Ecto.Types.{
    EncryptedMap,
    EncryptedString
  }

  @primary_key {:id, :binary_id, autogenerate: false}
  
  schema "accounts" do
    field :credentials, EncryptedMap
    field :platform, :string
    field :secret, EncryptedString

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:platform, :secret, :credentials])
    |> validate_required([:platform, :secret, :credentials])
  end
end
