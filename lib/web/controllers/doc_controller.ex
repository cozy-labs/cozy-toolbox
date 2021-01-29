defmodule Web.DocController do
  use Web, :controller

  def show(conn, %{"page" => page}) do
    render(conn, "#{page}.html")
  end
end
