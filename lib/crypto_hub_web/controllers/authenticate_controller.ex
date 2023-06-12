defmodule CryptoHubWeb.AuthenticateController do
  use CryptoHubWeb, :controller

  alias CryptoHubWeb.Requests.AuthenticateByLoginRequest
  alias CryptoHub.Authenticate.AuthenticateByLoginCommand
  alias CryptoHub.Commands.{
    ReleaseAccessTokenCommand,
    StartAccountProcessesCommand
  }

  require Logger

  def auth(conn, params) do
    Logger.info("auth action params: #{inspect params}")
    with {:ok, %{login: login, password: pass}} <- AuthenticateByLoginRequest.make(params),
         {:ok, user} <- AuthenticateByLoginCommand.execute(login, pass),
         {:ok, token} = ReleaseAccessTokenCommand.execute(user, conn)
    do
      StartAccountProcessesCommand.execute(user)

      conn
      |> put_resp_header("content-type", "application/json")
      |> send_resp(200, Jason.encode!(%{"access_token" => token}))
    else
      error ->
        Logger.error("authentication errror: #{inspect error}")

        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(400, Jason.encode!(%{"error" => "Invalid login or password"}))
    end
  end
end
