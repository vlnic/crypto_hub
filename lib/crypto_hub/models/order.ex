defmodule CryptoHub.Order do
  use Ecto.Schema

  import Ecto.Changeset

  @fields ~w(trade_type account_id limit start_from next_order prev_order)a

  @primary_key {:order_id, UUID5, autogenerate: false}

  schema "orders" do
    field :trade_type, :string
    field :account_id, UUID5
    field :limit, :boolean
    field :cost, :decimal
    field :comission, :decimal, default: nil
    field :start_from, :decimal, default: nil
    field :next_order, :integer, default: nil
    field :prev_order, :integer, default: nil

    timestamps()
  end

  def changeset(model, params) do
    model
    |> cast(params, @fields)
    |> validate_required([:trade_type, :account_id, :limit, :cost])
  end
end
