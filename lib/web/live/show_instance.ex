defmodule Web.ShowInstance do
  @moduledoc false
  use Web, :live_view

  alias Web.Models.Doctype
  alias Web.Models.Instance

  @impl true
  def mount(%{"cozy" => cozy}, _session, socket) do
    instance = Instance.get(cozy)
    prefix = Instance.get_prefix(instance)
    doctypes = Doctype.with_prefix(prefix)

    socket =
      socket
      |> assign(:instance, instance)
      |> assign(:doctypes, doctypes)

    {:ok, socket |> push_event("highlight", %{})}
  end
end
