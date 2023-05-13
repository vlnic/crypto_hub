defmodule CryptoHubWeb.Router do
  use CryptoHubWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {CryptoHubWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :public_api do
    plug :accepts, ["json"]
  end

  scope "/api", CryptoHubWeb do
    pipe_through :public_api

    post "/auth", AuthenticateController, :auth
  end

  scope "/", CryptoHubWeb do
    pipe_through :browser

    get "/home", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", CryptoHubWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:crypto_hub, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: CryptoHubWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
