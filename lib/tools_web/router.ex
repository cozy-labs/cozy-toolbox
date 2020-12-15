defmodule ToolsWeb.Router do
  use ToolsWeb, :router
  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
  end

  scope "/", ToolsWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/doc/:page", DocController, :show
    live_dashboard "/dashboard", metrics: ToolsWeb.Telemetry

    get "/oidc", OidcController, :index
    get "/oidc/:backend/authorize", OidcController, :authorize
    post "/oidc/:backend/authorize", OidcController, :authorized
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ToolsWeb do
    pipe_through :api

    post "/oidc/:backend/token", OidcController, :token
    get "/oidc/:backend/userinfo", OidcController, :userinfo
  end
end
