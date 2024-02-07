defmodule Web.ShowDoctype do
  use Web, :live_view

  alias Web.Models.Couch
  alias Web.Models.Document
  alias Web.Models.Doctype
  alias Web.Models.Instance

  @impl true
  def mount(%{"cozy" => cozy, "doctype" => doctypename}, _session, socket) do
    instance = Instance.get(cozy)
    prefix = Instance.get_prefix(instance)
    doctypes = Doctype.with_prefix(prefix)
    doctype = Enum.find(doctypes, fn d -> d.name == doctypename end)
    docs = Document.list(doctype)

    socket =
      socket
      |> assign(:instance, instance)
      |> assign(:doctypes, doctypes)
      |> assign(:doctype, doctype)
      |> assign(:docs, docs)
      |> assign(:kind, "normal_docs")

    {:ok, socket}
  end

  @impl true
  def handle_event("normal_docs", _params, socket) do
    {:ok, doctype} = Map.fetch(socket.assigns, :doctype)
    docs = Document.list(doctype)
    {:noreply, socket |> assign(:docs, docs) |> assign(:kind, "normal_docs")}
  end

  @impl true
  def handle_event("design_docs", _params, socket) do
    {:ok, doctype} = Map.fetch(socket.assigns, :doctype)
    docs = Document.design_docs(doctype)
    {:noreply, socket |> assign(:docs, docs) |> assign(:kind, "design_docs")}
  end

  @impl true
  def handle_event("local_docs", _params, socket) do
    {:ok, doctype} = Map.fetch(socket.assigns, :doctype)
    docs = Document.local_docs(doctype)
    {:noreply, socket |> assign(:docs, docs) |> assign(:kind, "local_docs")}
  end
end
