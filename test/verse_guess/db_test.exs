defmodule VerseGuess.DbTest do
  use ExUnit.Case
  alias VerseGuess.Db

  test "can save" do
    
    assert :ok = Db.save(:dbtest, {:my_id, "some-field"})
  end
end
