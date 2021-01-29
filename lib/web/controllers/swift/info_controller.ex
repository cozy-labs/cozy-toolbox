defmodule Web.Swift.InfoController do
  use Web, :controller

  def index(conn, _params) do
    json(conn, %{})
  end
end
