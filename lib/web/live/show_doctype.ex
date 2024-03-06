defmodule Web.ShowDoctype do
  @moduledoc false
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
  def handle_params(params, _uri, socket) do
    {:ok, doctype} = Map.fetch(socket.assigns, :doctype)

    socket =
      case params["kind"] do
        "normal_docs" ->
          docs = Document.list(doctype)
          fields = Field.list(doctype.name)
          socket |> assign(docs: docs) |> assign(fields: fields) |> assign(kind: "normal_docs")

        "design_docs" ->
          docs = Document.design_docs(doctype)
          fields = Field.list("design_docs")
          socket |> assign(docs: docs) |> assign(fields: fields) |> assign(kind: "design_docs")

        "local_docs" ->
          docs = Document.local_docs(doctype)
          fields = Field.list("local_docs")
          socket |> assign(docs: docs) |> assign(fields: fields) |> assign(kind: "local_docs")

        _ ->
          socket
      end

    socket =
      case params["view"] do
        view when view in ~w(table list) -> assign(socket, view: view)
        _ -> socket
      end

    {:noreply, socket}
  end
end
