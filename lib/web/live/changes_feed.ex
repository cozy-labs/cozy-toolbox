defmodule Web.ChangesFeed do
  @moduledoc false
  use Web, :live_view

  alias Web.Models.Couch
  alias Web.Models.Doctype
  alias Web.Models.Document
  alias Web.Models.Instance

  @impl true
  def mount(%{"cozy" => cozy, "doctype" => doctypename}, _session, socket) do
    instance = Instance.get(cozy)
    prefix = Instance.get_prefix(instance)
    doctypes = Doctype.with_prefix(prefix)
    doctype = Enum.find(doctypes, fn d -> d.name == doctypename end)
    results = Document.changes_feed(doctype)

    socket =
      socket
      |> assign(:instance, instance)
      |> assign(:doctypes, doctypes)
      |> assign(:doctype, doctype)
      |> assign(:results, results)

    {:ok, socket}
  end
end
