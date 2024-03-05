defmodule Web.ShowDoctype do
  use Web, :live_view

  alias Web.Models.Couch
  alias Web.Models.Doctype
  alias Web.Models.Document
  alias Web.Models.Field
  alias Web.Models.Instance

  @impl true
  def mount(%{"cozy" => cozy, "doctype" => doctypename}, _session, socket) do
    instance = Instance.get(cozy)
    prefix = Instance.get_prefix(instance)
    doctypes = Doctype.with_prefix(prefix)
    doctype = Enum.find(doctypes, fn d -> d.name == doctypename end)
    docs = Document.list(doctype)
    fields = Field.list(doctype.name)

    socket =
      socket
      |> assign(:instance, instance)
      |> assign(:doctypes, doctypes)
      |> assign(:doctype, doctype)
      |> assign(:docs, docs)
      |> assign(:fields, fields)
      |> assign(:kind, "normal_docs")
      |> assign(:view, "table")

    {:ok, socket}
  end

  @impl true
  def handle_event("normal_docs", _params, socket) do
    {:ok, doctype} = Map.fetch(socket.assigns, :doctype)
    docs = Document.list(doctype)
    fields = Field.list(doctype.name)

    {:noreply,
     socket |> assign(:docs, docs) |> assign(:fields, fields) |> assign(:kind, "normal_docs")}
  end

  @impl true
  def handle_event("design_docs", _params, socket) do
    {:ok, doctype} = Map.fetch(socket.assigns, :doctype)
    docs = Document.design_docs(doctype)
    fields = Field.list("design_docs")

    {:noreply,
     socket |> assign(:docs, docs) |> assign(:fields, fields) |> assign(:kind, "design_docs")}
  end

  @impl true
  def handle_event("local_docs", _params, socket) do
    {:ok, doctype} = Map.fetch(socket.assigns, :doctype)
    docs = Document.local_docs(doctype)
    fields = Field.list("local_docs")

    {:noreply,
     socket |> assign(:docs, docs) |> assign(:fields, fields) |> assign(:kind, "local_docs")}
  end

  @impl true
  def handle_event("view_table", _params, socket) do
    {:noreply, socket |> assign(:view, "table")}
  end

  @impl true
  def handle_event("view_list", _params, socket) do
    {:noreply, socket |> assign(:view, "list")}
  end
end
