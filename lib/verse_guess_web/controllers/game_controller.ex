defmodule VerseGuessWeb.GameController do
  use VerseGuessWeb, :controller

  alias VerseGuess.Game
  alias VerseGuess.Player

  def new(conn, _params) do
    # {:ok, player_pid} = Player.start_link()
    {:ok, game_pid} = Game.start_link()
    # Game.add_player(game_pid, player_pid, "Host") 
    verse_text = Game.new_round(game_pid)

    conn
    |> Plug.Conn.assign(:verse_text, verse_text)
    |> Plug.Conn.put_session(:game_pid, game_pid)
    # |> Plug.Conn.put_session(:player_pid, player_pid)
    |> render("new.html") 
  end
end
