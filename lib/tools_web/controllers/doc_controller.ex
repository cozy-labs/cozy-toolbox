defmodule ToolsWeb.DocController do
  use ToolsWeb, :controller

  def show(conn, %{"page" => page}) do
    render(conn, "#{page}.html")
  end
end
