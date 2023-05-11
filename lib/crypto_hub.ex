defmodule CryptoHub do
  @config Application.compile_env(:crypto_hub, :config_impl, CryptoHub.Config)

  def user_session_ttl do
    @config.get(:user_session_ttl, 60)
  end

  def access_token_salt do
    @config.get(:access_token_salt)
  end
end
