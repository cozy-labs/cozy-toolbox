defmodule Web.Router do
  use Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :put_root_layout, html: {Web.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Web do
    pipe_through :browser
    live "/", HomeLive
    live "/cozy/:cozy", ShowInstance
    get "/cozy/:cozy/:doctype", DocumentController, :index
    live "/cozy/:cozy/:doctype/:docid", ShowDoc
  end
end
