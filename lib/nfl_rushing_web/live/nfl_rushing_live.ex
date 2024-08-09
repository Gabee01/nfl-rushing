defmodule NflRushingWeb.NflRushingLive do
  @moduledoc """
  LiveView module for handling the NFL Rushing statistics page.
  This module manages the live updates for searching, sorting, and displaying player data.
  """
  use NflRushingWeb, :live_view

  alias NflRushing

  @sortable_fields ~w(name total_rushing_yards longest_rush total_rushing_touchdowns)
  @initial_state %{query: %{}, players: NflRushing.list()}

  @doc """
  Initializes the LiveView with the initial state.
  """
  @impl true
  @spec mount(map(), map(), Phoenix.LiveView.Socket.t()) :: {:ok, Phoenix.LiveView.Socket.t()}
  def mount(_params, _session, socket) do
    {:ok, assign(socket, @initial_state)}
  end

  @doc """
  Handles the search event, filtering players by name.
  """
  @impl true
  @spec handle_event(String.t(), map(), Phoenix.LiveView.Socket.t()) :: {:noreply, Phoenix.LiveView.Socket.t()}
  def handle_event("search", %{"player" => %{"name" => name}}, socket) do
    players = NflRushing.list() |> NflRushing.find_by_name(name)
    {:noreply, assign(socket, players: players)}
  end

  @doc """
  Handles URL parameters, specifically for sorting players.
  """
  @impl true
  @spec handle_params(map(), String.t(), Phoenix.LiveView.Socket.t()) :: {:noreply, Phoenix.LiveView.Socket.t()}
  def handle_params(%{"sort_by" => sort_by}, _uri, socket) when sort_by in @sortable_fields do
    players = NflRushing.order_by(socket.assigns.players, sort_by)
    {:noreply, assign(socket, players: players)}
  end

  def handle_params(_params, _uri, socket), do: {:noreply, socket}
end
