defmodule Web.HomeLive do
  use Web, :live_view

  alias Web.Models.Instance

  @impl true
  def mount(_params, _session, socket) do
    instances = Instance.list(limit: 30)
    {:ok, socket |> assign(:instances, instances)}
  end

  @impl true
  def handle_event("search", %{"q" => q}, socket) do
    instances = Instance.search(q, limit: 30)
    {:noreply, socket |> assign(:instances, instances)}
  end

  @impl true
  def handle_event("submit", %{"q" => q}, socket) do
    [instance] = Instance.search(q, limit: 1)
    {:noreply, socket |> redirect(to: ~p"/cozy/#{instance.id}")}
  end
end
