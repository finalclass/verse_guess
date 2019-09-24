defmodule VerseGuess.GameTest do
  use ExUnit.Case
  alias VerseGuess.Game

  doctest Game

  setup do
    {:ok, game_pid} = Game.start_link()
    on_exit(fn -> Process.exit(game_pid, :normal) end)
    %{game_pid: game_pid}
  end

  # test "initializes new round", %{game_pid: game_pid} do
  #   verse_text = Game.new_(game_pid)
  #   assert verse_text == Application.get_env(:verse_guess, :http_client_response_verse_text)
  # end

  # test "gets options", %{game_pid: game_pid} do
  #   options = Game.get_options(game_pid)
  #   assert options == ["Stary Testament", "Nowy Testament"]
  # end

  # test "changes guess options", %{game_pid: game_pid} do
  #   Game.next_stage(game_pid)
  #   options = Game.get_options(game_pid)
  #   assert options == ["Prawo", "Pisma", "Prorocy"]
  # end
end
