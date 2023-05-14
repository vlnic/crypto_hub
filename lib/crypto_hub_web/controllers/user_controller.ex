defmodule CryptoHubWeb.UserController do
  use CryptoHubWeb, :controller

  def show(conn, _params) do
    user = conn.assigns.user
    result = %{
      "login" => user.login,
      "email" => user.email
    }

    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, Jason.encode!(result))
  end
end
