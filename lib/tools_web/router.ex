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
  end
end
