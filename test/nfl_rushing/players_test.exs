defmodule NflRushing.PlayersTest do
  @moduledoc false
  use ExUnit.Case

  alias NflRushing.Players
  @players File.read!("rushing.json") |> Jason.decode!()

  @player %{
    "Player" => "Rashad Jennings",
    "Team" => "NYG",
    "Pos" => "RB",
    "Att" => 181,
    "Att/G" => 13.9,
    "Yds" => "593",
    "Avg" => 3.3,
    "Yds/G" => 45.6,
    "TD" => 3,
    "Lng" => "25",
    "1st" => 29,
    "1st%" => 16,
    "20+" => 3,
    "40+" => 0,
    "FUM" => 0
  }

  describe("list/0") do
    test "lists all players from rushing.json", do: assert(Players.list() == @players)
  end

  describe "find/1" do
    setup do
      players = [
        %{@player | "Player" => "Chiquinha"},
        %{@player | "Player" => "Leandro"},
        %{@player | "Player" => "Caetano"}
      ]

      {:ok, players: players}
    end

    test "returns players matching the searched name", %{players: players} do
      assert Players.find_by_name(players, "cae") == [%{@player | "Player" => "Caetano"}]
    end

    test "returns all players with blank name", %{players: players} do
      assert Players.find_by_name(players, "") == players
    end
  end

  describe("order_by/2") do
    test "orders a given list of players by total_rushing_yards (best first)" do
      best_player = %{@player | "Yds" => "1,010"}
      worst_player = %{@player | "Yds" => 200}
      players = [worst_player, best_player]
      opts = %{total_rushing_yards: :desc}
      assert [^best_player, ^worst_player] = Players.order_by(players, opts)
    end
  end
end
