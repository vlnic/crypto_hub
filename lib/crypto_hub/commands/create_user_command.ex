defmodule CryptoHub.Commands.CreateUserCommand do
  alias CryptoHub.Encryption.Hash
  alias CryptoHub.Repo
  alias CryptoHub.User

  def execute(login, email, password) do
    hashed_pass = Hash.hash_password(password)

    %User{}
    |> User.changeset(%{
      login: login,
      email: email,
      password: hashed_pass
    })
    |> Repo.insert()
  end
end
