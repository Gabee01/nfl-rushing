defmodule NflRushingWeb.PlayersLive do
  @moduledoc false
  use NflRushingWeb, :live_view

  alias NflRushing.Players

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: %{}, players: Players.list())}
  end

  @sortable_fields ~w(name total_rushing_yards longest_rush total_rushing_touchdowns)

  @impl true
  def handle_params(%{"name" => name}, _uri, socket) do
    players = Players.find_by_name(socket.assigns.players, name)
    {:noreply, assign(socket, players: players)}
  end

  @impl true
  def handle_params(%{"sort_by" => sort_by}, _uri, socket) do
    case sort_by do
      sort_by when sort_by in @sortable_fields ->
        players = Players.order_by(socket.assigns.players, sort_by)
        {:noreply, assign(socket, players: players)}

      _ ->
        {:noreply, socket}
    end
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end
end
