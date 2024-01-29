defmodule Web.InstanceController do
  use Web, :controller

  alias Web.Models.Couch
  alias Web.Models.Doctype
  alias Web.Models.Instance

  def index(conn, _params) do
    couch = Couch.default()
    instances = Instance.list(couch)
    render(conn, :index, %{instances: instances})
  end

  def show(conn, %{"id" => id}) do
    couch = Couch.default()
    instance = Instance.get(couch, id)
    doctypes = Doctype.with_prefix(couch, instance.prefix)
    render(conn, :show, %{instance: instance, doctypes: doctypes})
  end
end
