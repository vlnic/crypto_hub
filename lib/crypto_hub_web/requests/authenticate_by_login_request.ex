defmodule CryptoHubWeb.Requests.AuthenticateByLoginRequest do
  use Construct do
    field :login, :string
    field :password, :string
  end
end
