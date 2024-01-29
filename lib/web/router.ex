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
    resources "/instances", InstanceController, only: [:index, :show]
    live_dashboard "/dashboard", metrics: Web.Telemetry
  end
end
