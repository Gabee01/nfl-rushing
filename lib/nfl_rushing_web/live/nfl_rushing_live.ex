defmodule NflRushingWeb.NflRushingLive do
  @moduledoc false
  use NflRushingWeb, :live_view

  alias NflRushing

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: %{}, players: NflRushing.list())}
  end

  @sortable_fields ~w(name total_rushing_yards longest_rush total_rushing_touchdowns)

  @impl true
  def handle_event("search", %{"player" => %{"name" => name}}, socket) do
    players = NflRushing.list() |> NflRushing.find_by_name(name)
    {:noreply, assign(socket, players: players)}
  end

  @impl true
  def handle_params(%{"sort_by" => sort_by}, _uri, socket) do
    if sort_by in @sortable_fields do
      players = NflRushing.order_by(socket.assigns.players, sort_by)
      {:noreply, assign(socket, players: players)}
    else
      {:noreply, socket}
    end
  end

  def handle_params(_params, _uri, socket), do: {:noreply, socket}
end
