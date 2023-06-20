defmodule CryptoHub.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders, primary_key: false) do
      add :order_id, :uuid, primary_key: true
      add :trade_type, :string
      add :account_id, :uuid
      add :limit, :boolean
      add :cost, :decimal
      add :comission, :decimal
      add :start_from, :utc_datetime_usec
      add :next_order, :string
      add :prev_order, :string

      timestamps()
    end
  end
end
