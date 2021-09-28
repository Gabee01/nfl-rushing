defmodule NflRushing.Players do
  @moduledoc false
  def list, do: File.read!("rushing.json") |> Jason.decode!()

  def find_by_name(players, name)
  def find_by_name(players, ""), do: players
  def find_by_name(players, name), do: Enum.filter(players, &filter_name(&1, name))

  def order_by(players, "name"), do: Enum.sort_by(players, fn player -> player["Player"] end)

  def order_by(players, "total_rushing_yards"),
    do: Enum.sort_by(players, &total_rushing_yards/1, :desc)

  def order_by(players, "total_rushing_touchdowns"),
    do: players |> Enum.sort_by(&total_rushing_touchdowns/1, :desc)

  def order_by(players, "longest_rush") do
    touchdowns = players |> Enum.filter(&touchdown?/1) |> Enum.sort_by(&longest_rush/1, :desc)
    not_touchdowns = players |> Enum.reject(&touchdown?/1) |> Enum.sort_by(&longest_rush/1, :desc)

    touchdowns ++ not_touchdowns
  end

  defp total_rushing_yards(%{"Yds" => total_rushing_yards}) do
    cond do
      is_number(total_rushing_yards) -> total_rushing_yards
      is_binary(total_rushing_yards) -> parse_integer(total_rushing_yards)
    end
  end

  defp total_rushing_touchdowns(player), do: Map.get(player, "TD")

  defp touchdown?(%{"Lng" => longest_rush}),
    do: longest_rush |> to_string() |> String.contains?("T")

  defp longest_rush(%{"Lng" => longest_rush}) do
    cond do
      is_number(longest_rush) -> longest_rush
      is_binary(longest_rush) -> parse_integer(longest_rush)
    end
  end

  defp parse_integer(string) do
    string |> String.replace(",", "") |> String.replace("T", "") |> Integer.parse()
  end

  defp filter_name(%{"Player" => player_name}, filtered_name) do
    player_name = String.downcase(player_name)
    filtered_name = String.downcase(filtered_name)
    String.contains?(player_name, filtered_name)
  end
end
