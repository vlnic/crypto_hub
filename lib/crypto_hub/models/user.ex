defmodule CryptoHub.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias CryptoHub.Repo
  alias CryptoHub.User

  @primary_key {:id, UUID5, autogenerate: false}

  schema "users" do
    field :login, :string
    field :email, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:login, :password, :email, :id])
    |> unique_constraint([:login])
    |> validate_required([:login, :password])
  end

  def by_login(login) do
    case Repo.get_by(User, %{login: login}) do
      nil ->
        {:error, :user_not_found}

      user ->
        {:ok, user}
    end
  end
end
