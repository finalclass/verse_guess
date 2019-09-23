defmodule VerseGuessWeb.Controllers.Helpers do
  import Plug.Conn

  @doc """
  ## Examples

  iex> require Phoenix.ConnTest; VerseGuessWeb.Controllers.Helpers.get_player_pid(Phoenix.ConnTest.get(Phoenix.ConnTest.bypass_through(Phoenix.ConnTest.build_conn()), "/")) 
  nil 
  """
  def get_player_pid(conn) do
    get_pid_from_session(conn, :player)
  end

  def get_game_pid(conn) do
    get_pid_from_session(conn, :game)
  end

  defp get_pid_from_session(conn, session_entry) do
    pid =
      conn
      |> fetch_session()
      |> get_session(session_entry)

    
    pid_or_nil(pid, pid != nil and Process.alive?(pid))
  end

  defp pid_or_nil(_player, false), do: nil
  defp pid_or_nil(player, true), do: player
end
