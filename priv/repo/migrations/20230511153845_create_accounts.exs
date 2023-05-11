defmodule CryptoHub.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :platform, :string
      add :secret, :text
      add :credentials, :text

      timestamps()
    end
  end
end
