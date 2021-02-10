defmodule Web.PageController do
  use Web, :controller

  alias Web.Models.Couch
  alias Web.Models.Instance

  def index(conn, _params) do
    couch = Couch.default()
    instances = Instance.list(couch)
    render(conn, "index.html", %{instances: instances})
  end
end
