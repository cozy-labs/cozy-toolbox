defmodule ToolsWeb.PageController do
  use ToolsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
