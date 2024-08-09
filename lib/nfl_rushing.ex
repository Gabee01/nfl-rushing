defmodule NflRushing do
  @moduledoc """
  NflRushing handles the core business logic for processing NFL rushing statistics.
  This module provides functions for listing, sorting, and filtering player data.
  """

  @doc """
  Reads and parses the rushing.json file containing player statistics.

  Returns a list of maps, where each map represents a player's statistics.
  """
  @spec list() :: list(map())
  def list, do: File.read!("rushing.json") |> Jason.decode!()

  @doc """
  Sorts the list of players based on the specified field.

  ## Parameters

    - players: List of player maps
    - field: String representing the field to sort by ("name", "total_rushing_yards", "total_rushing_touchdowns", or "longest_rush")

  Returns the sorted list of player maps.
  """
  @spec order_by(list(map()), binary()) :: list(map())
  def order_by(players, field) do
    sorter = sort_function(field)
    sorted_players = Enum.sort_by(players, sorter, sort_order(field))
    reverse_if_already_sorted(sorted_players, players)
  end

  @doc """
  Filters the list of players by name.

  ## Parameters

    - players: List of player maps
    - name: String to filter player names by

  Returns the filtered list of player maps.
  """
  @spec find_by_name(list(map()), binary()) :: list(map())
  def find_by_name(players, name) do
    if name == "" do
      players
    else
      Enum.filter(players, &filter_name(&1, name))
    end
  end

  # Private functions

  defp sort_function("name"), do: &name/1
  defp sort_function("total_rushing_yards"), do: &parse_total_rushing_yards/1
  defp sort_function("total_rushing_touchdowns"), do: &total_rushing_touchdowns/1
  defp sort_function("longest_rush"), do: &parse_longest_rush/1

  defp sort_order("name"), do: :asc
  defp sort_order(_), do: :desc

  defp parse_total_rushing_yards(%{"Yds" => total_rushing_yards}) do
    parse_numeric_value(total_rushing_yards)
  end

  defp parse_longest_rush(%{"Lng" => longest_rush}) do
    parse_numeric_value(longest_rush)
  end

  defp parse_numeric_value(value) when is_number(value), do: value
  defp parse_numeric_value(value) when is_binary(value) do
    {integer, _} = value |> String.replace(~r/[,T]/, "") |> Integer.parse()
    integer
  end

  defp total_rushing_touchdowns(player), do: Map.get(player, "TD")
  defp name(player), do: Map.get(player, "Player")

  defp reverse_if_already_sorted(sorted_players, current_players) do
    if sorted_players == current_players do
      Enum.reverse(sorted_players)
    else
      sorted_players
    end
  end

  defp filter_name(%{"Player" => player_name}, filtered_name) do
    player_name = String.downcase(player_name)
    filtered_name = String.downcase(filtered_name)
    String.contains?(player_name, filtered_name)
  end
end
