defmodule NflRushingWeb.PlayersLive do
  @moduledoc false
  use NflRushingWeb, :live_view

  alias NflRushing.Players

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: %{}, players: Players.list())}
  end

  # @impl true
  # def handle_event("search", %{"q" => query}, socket) do
  #   case search(query) do
  #     %{^query => vsn} ->
  #       {:noreply, redirect(socket, external: "https://hexdocs.pm/#{query}/#{vsn}")}

  #     _ ->
  #       {:noreply,
  #        socket
  #        |> put_flash(:error, "No dependencies found matching \"#{query}\"")
  #        |> assign(players: %{}, query: query)}
  #   end
  # end

  # defp search(query) do
  #   if not NflRushingWeb.Endpoint.config(:code_reloader) do
  #     raise "action disabled when not in development"
  #   end

  #   for {app, desc, vsn} <- Application.started_applications(),
  #       app = to_string(app),
  #       String.starts_with?(app, query) and not List.starts_with?(desc, ~c"ERTS"),
  #       into: %{},
  #       do: {app, vsn}
  # end

  @sortable_fields ~w(name total_rushing_yards longest_rush total_rushing_touchdowns)

  @impl true
  def handle_params(%{"sort_by" => sort_by}, _uri, socket) do
    case sort_by do
      sort_by when sort_by in @sortable_fields ->
        {:noreply, assign(socket, players: sort_players(socket.assigns.players, sort_by))}

      _ ->
        {:noreply, socket}
    end
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  defp sort_players(players, sort_by) do
    sorted_players = Players.order_by(players, sort_by)
    reverse_sorting_when_already_sorted(players, sorted_players)
  end

  defp reverse_sorting_when_already_sorted(current_players, sorted_players)

  defp reverse_sorting_when_already_sorted(sorted_players, sorted_players) do
    Enum.reverse(sorted_players)
  end

  defp reverse_sorting_when_already_sorted(_current_players, sorted_players), do: sorted_players
end
