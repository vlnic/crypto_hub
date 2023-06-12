defmodule CryptoHub.Commands.ReleaseAccessTokenCommand do
  alias CryptoHub.User

  def execute(user, context \\ CryptoHubWeb.Endpoint)
  def execute(%User{} = user, context) do
    token = Phoenix.Token.sign(
      context,
      CryptoHub.access_token_salt(),
      token_payload(user),
      [max_age: CryptoHub.user_session_ttl()]
    )

    {:ok, token}
  end

  defp token_payload(%{id: id}) do
    %{user_id: id, issued: DateTime.utc_now() |> DateTime.to_unix()}
  end
end
