defmodule CryptoHubWeb.Plug.ProtectedApiPlug do
  import Plug.Conn

  alias CryptoHub.Repo
  alias CryptoHub.User

  def init(conn, _opts \\ []), do: conn

  def call(conn, _opts) do
    with {:ok, token} <- get_auth_header(conn),
         {:ok, %{user_id: id}} <- Phoenix.Token.verify(conn, CryptoHub.access_token_salt(), token, [max_age: :infinity])
    do
      user = Repo.get(User, id)

      conn
      |> assign(:user_id, id)
      |> assign(:user, user)
    end
  end

  defp get_auth_header(conn) do
    case get_req_header(conn, "authorization") do
      nil ->
        {:error, :token_missing}

      "" ->
        {:error, :token_missing}

      "Bearer " <> token ->
        {:ok, token}
    end
  end
end
