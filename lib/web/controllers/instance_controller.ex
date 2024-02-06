defmodule Web.InstanceController do
  use Web, :controller

  alias Web.Models.Doctype
  alias Web.Models.Instance

  def index(conn, _params) do
    live_render(conn, Web.HomeLive)
  end

  def show(conn, %{"cozy" => cozy}) do
    instance = Instance.get(cozy)
    prefix = Instance.get_prefix(instance)
    doctypes = Doctype.with_prefix(prefix)
    render(conn, :show, %{instance: instance, doctypes: doctypes})
  end
end
