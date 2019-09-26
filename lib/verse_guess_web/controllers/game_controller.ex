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

  def round(conn, _params) do
    game_pid = Map.get(conn, :game)
    player_pid = Map.get(conn, :player)
    verse_text = Game.get_verse_text(game_pid)
    points = Player.get_points(player_pid)
    known = Game.get_known(game_pid)
    {_, choice_name, possible_answers, _} = Game.get_options(game_pid)

    conn
    |> assign(:verse_text, verse_text)
    |> assign(:choice_name, choice_name)
    |> assign(:possible_answers, possible_answers)
    |> assign(:points, points)
    |> assign(:known, known)
    |> render("round.html")
  end

  def answer(conn, %{"answer_index" => answer_index_str }) do
    game_pid = Map.get(conn, :game)
    player_pid = Map.get(conn, :player)

    {answer_index, _} = Integer.parse(answer_index_str)

    Game.answer(game_pid, player_pid, answer_index) 
    Game.next_stage(game_pid)

    redirect(conn, to: Routes.game_path(conn, :round))
  end
end
