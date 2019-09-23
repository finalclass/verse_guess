defmodule VerseGuess.GameTest do
  use ExUnit.Case
  alias VerseGuess.Game
  
  doctest Game

  test "initializes new round" do
    {:ok, game_pid} = Game.start_link()
    verse_text = Game.new_round(game_pid)
    assert verse_text == Application.get_env(:verse_guess, :http_client_response_verse_text)
  end

end
