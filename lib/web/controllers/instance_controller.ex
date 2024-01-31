defmodule Web.InstanceController do
  use Web, :controller

  alias Web.Models.Couch
  alias Web.Models.Doctype
  alias Web.Models.Instance

  def index(conn, _params) do
    live_render(conn, Web.HomeLive)
  end

  def show(conn, %{"id" => id}) do
    couch = Couch.default()
    instance = Instance.get(couch, id)
    prefix = Instance.get_prefix(instance)
    doctypes = Doctype.with_prefix(couch, prefix)
    render(conn, :show, %{instance: instance, doctypes: doctypes})
  end
end
