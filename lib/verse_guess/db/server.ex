defmodule VerseGuess.Db.Server do
  use GenServer
  alias VerseGuess.Db.Impl

  def init(init_arg) do
    {:ok, init_arg}
  end

  def handle_call({:save, table, fields}, _from, state) do
    {:reply, Impl.save(table, fields), state}
  end

  def handle_call({:get, table, id}, _from, state) do
    {:reply, Impl.get(table, id), state}
  end
end
