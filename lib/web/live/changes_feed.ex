defmodule Web.ChangesFeed do
  @moduledoc false
  use Web, :live_view

  alias Web.Models.Changes
  alias Web.Models.Couch
  alias Web.Models.Doctype
  alias Web.Models.Instance

  @impl true
  def mount(%{"cozy" => cozy, "doctype" => doctypename}, _session, socket) do
    instance = Instance.get(cozy)
    prefix = Instance.get_prefix(instance)
    doctypes = Doctype.with_prefix(prefix)
    doctype = Enum.find(doctypes, fn d -> d.name == doctypename end)

    if connected?(socket) do
      start_stream(doctype)
    end

    socket =
      socket
      |> assign(:instance, instance)
      |> assign(:doctypes, doctypes)
      |> assign(:doctype, doctype)
      |> stream(:results, [])

    {:ok, socket}
  end

  @impl true
  def handle_info({:add_result, result}, socket) do
    {:noreply, socket |> stream_insert(:results, result, at: 0) |> push_event("highlight", %{})}
  end

  defp start_stream(doctype) do
    pid = self()

    {:ok, _} =
      Task.start_link(fn ->
        Changes.stream(pid, doctype)
      end)
  end
end
