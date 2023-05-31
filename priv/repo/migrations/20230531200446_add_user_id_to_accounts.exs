defmodule CryptoHub.Repo.Migrations.AddUserIdToAccounts do
  use Ecto.Migration

  def change do
    modify table(:accounts) do
      add :user_id, :string
    end
  end
end
