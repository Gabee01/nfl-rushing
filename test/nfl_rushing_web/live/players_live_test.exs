defmodule NflRushingWeb.PlayersLiveTest do
  use NflRushingWeb.ConnCase

  import Phoenix.LiveViewTest

  test "renders all players", %{conn: conn} do
    {:ok, players_live, _disconnected_html} = live(conn, "/")

    assert render(players_live) =~ "Player Name"
    assert render(players_live) =~ "Total Rushing Yards"
    assert render(players_live) =~ "Longest Rush"
    assert render(players_live) =~ "Total Rushing Touchdowns"

    assert render(players_live) =~
             ~s(<tr><th scope="row">Ezekiel Elliott</th><td>1,631</td><td>60T</td><td>15</td></tr>)
  end
end
