defmodule Web.Router do
  use Web, :router
  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Web do
    pipe_through :browser
    get "/", PageController, :index
    get "/avatars/:seed", AvatarController, :show
    get "/doc/:page", DocController, :show
    resources "/instances", InstanceController, only: [:index, :show]
    live_dashboard "/dashboard", metrics: Web.Telemetry
  end

  # Fake FranceConnect server
  scope "/", Web do
    pipe_through :browser
    get "/franceconnect", FranceConnectController, :index
    get "/api/v1/authorize", FranceConnectController, :authorize
    post "/api/v1/authorize", FranceConnectController, :authorized
  end

  scope "/", Web do
    pipe_through :api
    post "/api/v1/token", FranceConnectController, :token
    get "/api/v1/userinfo", FranceConnectController, :userinfo
  end

  # Fake OIDC server
  scope "/", Web do
    pipe_through :browser
    get "/oidc", OidcController, :index
    get "/oidc/:backend/authorize", OidcController, :authorize
    post "/oidc/:backend/authorize", OidcController, :authorized
  end

  scope "/", Web do
    pipe_through :api
    post "/oidc/:backend/token", OidcController, :token
    get "/oidc/:backend/userinfo", OidcController, :userinfo
  end
end
