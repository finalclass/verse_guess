defmodule VerseGuess.GameTest do
  use ExUnit.Case
  alias VerseGuess.Game

  doctest Game

  setup do
    {:ok, game_pid} = Game.start_link()
    on_exit(fn -> Process.exit(game_pid, :normal) end)
    %{game_pid: game_pid}
  end

  test "simple round", %{game_pid: game_pid} do
    options = Game.get_options(game_pid)
    assert options == {:testament, "Testament", ["Stary Testament", "Nowy Testament"], 0}
  end

  test "next stage", %{game_pid: game_pid} do
    Game.next_stage(game_pid)
    options = Game.get_options(game_pid)
    assert options == {:section, "Dział", ["Prawo", "Pisma", "Prorocy"], 2}
  end

  test "next stage goes to new round when finished", %{game_pid: game_pid} do
    Game.next_stage(game_pid)
    Game.next_stage(game_pid)
    Game.next_stage(game_pid)
    Game.next_stage(game_pid)
    options = Game.get_options(game_pid)
    assert options == {:testament, "Testament", ["Stary Testament", "Nowy Testament"], 0}
  end

end
