defmodule CryptoHubWeb.AuthenticateController do
  use CryptoHubWeb, :controller

  alias CryptoHubWeb.Requests.AuthenticateByLoginRequest
  alias CryptoHub.Authenticate.AuthenticateByLoginCommand
  alias CryptoHub.Commands.ReleaseAccessTokenCommand

  def auth(conn, params) do
    with {:ok, %{login: login, password: pass}} <- AuthenticateByLoginRequest.make(params),
         {:ok, user} <- AuthenticateByLoginCommand.execute(login, pass)
    do
      token = ReleaseAccessTokenCommand.execute(user, conn)

      conn
      |> put_resp_cookie(:access_token, token)
      |> render("")
    end
  end
end
