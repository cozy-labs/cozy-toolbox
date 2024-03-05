defmodule Web.ShowDoc do
  use Web, :live_view

  alias Web.Models.Couch
  alias Web.Models.Doctype
  alias Web.Models.Document
  alias Web.Models.Instance
  alias Web.Models.Related

  @impl true
  def mount(%{"cozy" => cozy, "doctype" => doctypename, "docid" => docid}, _session, socket) do
    instance = Instance.get(cozy)
    prefix = Instance.get_prefix(instance)
    doctypes = Doctype.with_prefix(prefix)
    doctype = Enum.find(doctypes, fn d -> d.name == doctypename end)
    doc = Document.get(doctype, docid)
    rels = Related.extract(doctype.name, doc)

    socket =
      socket
      |> assign(:instance, instance)
      |> assign(:doctypes, doctypes)
      |> assign(:doctype, doctype)
      |> assign(:doc, doc)
      |> assign(:rels, rels)
      |> assign(:with_revs, false)

    {:ok, socket |> push_event("highlight", %{})}
  end

  @impl true
  def handle_event("toggle_revisions", _params, socket) do
    {:ok, doctype} = Map.fetch(socket.assigns, :doctype)
    {:ok, doc} = Map.fetch(socket.assigns, :doc)
    {:ok, with_revs} = Map.fetch(socket.assigns, :with_revs)
    with_revs = !with_revs
    doc = Document.get(doctype, doc.id, %{revs: with_revs})

    socket =
      socket
      |> assign(:with_revs, with_revs)
      |> assign(:doc, doc)

    {:noreply, socket |> push_event("highlight", %{})}
  end
end
