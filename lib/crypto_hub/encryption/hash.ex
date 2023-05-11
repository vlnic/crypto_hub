defmodule CryptoHub.Encryption.Hash do
  @algorithm_impl Application.compile_env(:crypto_hub, :hash_impl)

  @type password :: binary()
  @type hashed :: binary()

  @callback hash_password(password()) :: binary()
  def hash_password(pass) do
    @algorithm_impl.hash_password(pass)
  end

  @callback verify(password(), hashed()) :: {:ok, :pass} | {:error, :invalid}
  def verify(pass, hashed) do
    @algorithm_impl.verify(pass, hashed)
  end
end
