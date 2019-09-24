defmodule VerseGuessWeb.GameController do
  use VerseGuessWeb, :controller

  alias VerseGuess.Game
  alias VerseGuess.Player

  plug :ensure_player, %{}
  plug :ensure_game, %{}

  def ensure_game(conn, _params) do
    case get_game_pid(conn) do
      nil ->
        {:ok, game_pid} = Game.start_link()
        player_pid = Map.get(conn, :player)
        player_name = Player.get_name(player_pid)
        Game.add_player(game_pid, player_pid, player_name)
        
        conn
        |> put_session(:game, game_pid)
        |> Map.put(:game, game_pid)
      game ->
        Map.put(conn, :game, game)
    end
  end
  
  def ensure_player(conn, _params) do
    case get_player_pid(conn) do
    nil ->
      conn
      |> put_flash(:warning, "Ustaw nazwę gracza")
      |> redirect(to: Routes.page_path(conn, :index))
    player ->
      Map.put(conn, :player, player)
    end
  end
  
  def new(conn, _params) do
    game_pid = Map.get(conn, :game)
    
    players = Game.get_players(game_pid) |> Enum.map(&elem(&1, 1))

    conn
    |> assign(:players, players)
    |> render("new.html")
  end

  def new_round(conn, _params) do
    game_pid = Map.get(conn, :game)
    Game.next_stage(game_pid)
    
    conn
    |> redirect(to: Routes.game_path(conn, :round))
  end

  def round(conn, _params) do
    verse_text = conn |> Map.get(:game) |> Game.get_verse_text()
    
    conn
    |> assign(:verse_text, verse_text)
    |> render("round.html")
  end
end
