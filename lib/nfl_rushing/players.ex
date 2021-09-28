defmodule NflRushing.Players do
  @moduledoc false
  def list, do: File.read!("rushing.json") |> Jason.decode!()

  def find_by_name(players, name)
  def find_by_name(players, ""), do: players
  def find_by_name(players, name), do: Enum.filter(players, &contains_name(&1, name))

  def order_by(players, %{total_rushing_yards: total_rushing_yards_order}) do
    Enum.sort_by(players, &total_rushing_yards/1, total_rushing_yards_order)
  end

  defp total_rushing_yards(player)

  defp total_rushing_yards(%{"Yds" => total_rushing_yards}) when is_number(total_rushing_yards) do
    total_rushing_yards
  end

  defp total_rushing_yards(%{"Yds" => total_rushing_yards}) when is_binary(total_rushing_yards) do
    total_rushing_yards |> String.replace(",", "") |> String.to_integer()
  end

  # for longest_rush, T is Touchdown (shoud come first)
  # defp longest_rush(player), do: Map.get(player, "Lng")
  # defp total_rushing_touchdowns(player), do: Map.get(player, "TD")

  defp contains_name(%{"Player" => player_name}, filtered_name) do
    player_name = String.downcase(player_name)
    filtered_name = String.downcase(filtered_name)
    String.contains?(player_name, filtered_name)
  end
end
