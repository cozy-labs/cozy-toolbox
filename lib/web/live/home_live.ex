defmodule Web.HomeLive do
  use Web, :live_view

  alias Web.Models.Couch
  alias Web.Models.Instance

  @impl true
  def mount(_params, _session, socket) do
    couch = Couch.default()
    instances = Instance.list(couch, limit: 30)
    {:ok, socket |> assign(:instances, instances) }
  end

  @impl true
  def handle_event("search", %{"q" => q}, socket) do
    couch = Couch.default()
    instances = Instance.search(couch, q, limit: 30)
    {:noreply, socket |> assign(:instances, instances)}
  end

  @impl true
  def handle_event("submit", %{"q" => q}, socket) do
    couch = Couch.default()
    [instance] = Instance.search(couch, q, limit: 1)
    {:noreply, socket |> redirect(to: ~p"/cozy/#{instance.id}") }
  end
end
