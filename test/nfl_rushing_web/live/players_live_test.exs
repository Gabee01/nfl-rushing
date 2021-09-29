defmodule NflRushingWeb.PlayersLiveTest do
  @moduledoc false
  use NflRushingWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "/" do
    test "renders all players", %{conn: conn} do
      {:ok, players_live, _disconnected_html} = live(conn, "/")
      assert render(players_live) =~ NflRushingWeb.Examples.all_players()
    end
  end

  describe "search by name" do
    test "renders players filtered by name", %{conn: conn} do
      {:ok, players_live, _disconnected_html} = live(conn, "/")
      search = %{player: %{name: "Joe"}}
      assert render_submit(players_live, :search, search) =~ NflRushingWeb.Examples.all_joes()
    end

    test "renders empty table when no name is found", %{conn: conn} do
      {:ok, players_live, _disconnected_html} = live(conn, "/")
      search = %{player: %{name: "Joelson"}}
      assert render_submit(players_live, :search, search) =~ NflRushingWeb.Examples.empty_table()
    end
  end

  describe "/?sort_by" do
    test "renders unsorted players when sort_by is invalid", %{conn: conn} do
      {:ok, players_live, _disconnected_html} = live(conn, "/?sort_by=invalid_field")
      assert render(players_live) =~ NflRushingWeb.Examples.all_players()
    end

    test "renders players sorted by name", %{conn: conn} do
      {:ok, players_live, _disconnected_html} = live(conn, "/?sort_by=name")
      assert render(players_live) =~ NflRushingWeb.Examples.all_players_sorted_by_name()
    end

    test "renders players sorted by total_rushing_yards", %{conn: conn} do
      {:ok, players_live, _disconnected_html} = live(conn, "/?sort_by=total_rushing_yards")

      assert render(players_live) =~
               NflRushingWeb.Examples.all_players_sorted_by_total_rushing_yards()
    end

    test "renders players sorted by longest_rush", %{conn: conn} do
      {:ok, players_live, _disconnected_html} = live(conn, "/?sort_by=longest_rush")

      assert render(players_live) =~
               NflRushingWeb.Examples.all_players_sorted_by_longest_rush()
    end
  end

  test "renders players sorted by total_rushing_touchdowns", %{conn: conn} do
    {:ok, players_live, _disconnected_html} = live(conn, "/?sort_by=total_rushing_touchdowns")

    assert render(players_live) =~
             NflRushingWeb.Examples.all_players_sorted_by_total_rushing_touchdowns()
  end
end
