defmodule CryptoHub.Commands.ReleaseAccessTokenCommand do
  alias CryptoHub.User

  def execute(user, context \\ CryptoHubWeb.Endpoint)
  def execute(%User{} = user, context) do
    Phoenix.Token.sign(
      context,
      make_salt(user.id),
      token_payload(user),
      [max_age: CryptoHub.user_session_ttl()]
    )
  end

  defp token_payload(%{id: id}) do
    %{user_id: id, issued: DateTime.utc_now() |> DateTime.to_unix()}
  end

  defp make_salt(user_id) do
    "user_#{user_id}"
  end
end
