defmodule VerseGuessWeb.PageController do
  use VerseGuessWeb, :controller
  alias VerseGuess.Player

  def index(conn, _params) do
    player =
      conn
      |> fetch_session()
      |> get_session(:player)

    ensure_player(conn, {player, Process.alive?(player)})
  end

  defp ensure_player(conn, {nil, false}), do: render(conn, "new_player_form.html")
  defp ensure_player(conn, {player, false}), do: ensure_player(conn, {nil, false})

  defp ensure_player(conn, {player, true}) do
    IO.inspect(player)

    conn
    |> assign(:player_name, Player.get_name(player))
    |> render("main_menu.html")
  end

  def set_player_name(conn, %{"player_name" => ""}) do
    conn
    |> put_flash(:error, "Nazwa gracza nie może być pusta")
    |> ensure_player(nil)
  end

  def set_player_name(conn, %{"player_name" => player_name}) do
    {:ok, player_pid} = Player.start_link(player_name)

    conn
    |> put_session(:player, player_pid)
    |> put_flash(:info, "Pomyślnie ustawiono nazwę gracza")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
