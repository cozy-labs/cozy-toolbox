defmodule Web.DocumentController do
  use Web, :controller

  alias Web.Models.Document
  alias Web.Models.Doctype
  alias Web.Models.Instance

  def index(conn, %{"cozy" => cozy, "doctype" => doctypename}) do
    instance = Instance.get(cozy)
    prefix = Instance.get_prefix(instance)
    doctypes = Doctype.with_prefix(prefix)
    doctype = Enum.find(doctypes, fn d -> d.name == doctypename end)
    docs = Document.list(doctype)
    render(conn, :index, %{instance: instance, doctypes: doctypes, doctype: doctype, docs: docs})
  end
end
