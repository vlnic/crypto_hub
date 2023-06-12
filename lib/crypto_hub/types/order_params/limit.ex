defmodule CryptoHub.Types.OrderParams.Limit do
  use Construct do
    field :time_in_force, :string
    field :quantity, :integer
    field :price, :number
  end

  def cast(params) when is_map(params) or is_struct(params) do
    make(params)
  end
  def cast(_), do: {:error, :incorrect_limit_params}
end
