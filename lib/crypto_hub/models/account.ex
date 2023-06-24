defmodule CryptoHub.Account do
  use Ecto.Schema
  import Ecto.Query, only: [from: 2]
  import Ecto.Changeset

  alias CryptoHub.Account
  alias CryptoHub.Ecto.Types.{
    EncryptedMap,
    EncryptedString
  }
  alias CryptoHub.User
  alias CryptoHub.Repo

  @primary_key {:id, UUID5, autogenerate: false}

  schema "accounts" do
    field :credentials, EncryptedMap
    field :platform, :string
    field :secret, EncryptedString
    field :user_id, :string

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:platform, :secret, :credentials])
    |> validate_required([:platform, :secret, :credentials])
  end

  def by_user(%User{id: user_id}) do
    by_user(user_id)
  end

  def by_user(user_id) when is_binary(user_id) do
    query =
      from a in Account,
        where: a.user_id == ^user_id

    Repo.all(query)
  end
end
