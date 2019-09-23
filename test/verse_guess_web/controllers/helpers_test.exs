defmodule VerseGuessWeb.Controllers.HelpersTest do
  use VerseGuessWeb.ConnCase
  import VerseGuessWeb.Controllers.Helpers

  describe "get_player_pid" do
    test "returns nil if there is no pid set", %{conn: conn} do
      conn = get(conn, "/")
      assert get_player_pid(conn) == nil
    end
  end

  describe "get_game_pid" do
    test "returns nil if there is no pid set", %{conn: conn} do
      conn = get(conn, "/")
      assert get_game_pid(conn) == nil
    end
  end
end
