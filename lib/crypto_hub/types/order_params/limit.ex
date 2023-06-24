defmodule CryptoHub.Types.OrderParams.Limit do
  def cast(%{
    "time_in_force" => tif,
    "quantity" => q,
    "price" => price
  }) when is_binary(tif) and is_integer(q) and is_number(price) do
    {:ok, %{
      time_in_force: tif,
      quantity: q,
      price: price
    }}
  end
  def cast(_), do: {:error, :incorrect_limit_params}
end
