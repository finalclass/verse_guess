defmodule VerseGuess.DbTest do
  use ExUnit.Case
  alias VerseGuess.Db.Impl, as: Db 

  test "can save" do
    assert :ok == Db.save(:dbtest, {:my_id, "some-field"})
  end

  test "can get element by id" do
    assert :ok == Db.save(:dbtest, {:my_id, "some-field"})
    assert {:my_id, "some-field"} == Db.get(:dbtest, :my_id) 
  end

  test "can delete" do
    Db.save(:dbtest, {:my_id})
    Db.delete(:dbtest, :my_id)
    assert Db.get(:dbtest, :my_id) == nil
  end
  
end
