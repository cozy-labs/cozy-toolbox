defmodule ToolsWeb.Router do
  use ToolsWeb, :router
  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
  end

  scope "/", ToolsWeb do
    pipe_through :browser

    get "/", PageController, :index
    live_dashboard "/dashboard", metrics: ToolsWeb.Telemetry
  end
end
