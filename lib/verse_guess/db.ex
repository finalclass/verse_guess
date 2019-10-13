defmodule VerseGuess.Db do
  @server __MODULE__.Server

  def start_link() do
    GenServer.start_link(@server, %{}, name: @server)
  end

  @spec save(atom(), tuple()) :: :ok | {:error, term()}
  def save(table, fields) do
    GenServer.call(@server, {:save, table, fields})
  end

  @spec get(atom(), term()) :: tuple() | nil
  def get(table, id) do
    GenServer.call(@server, {:get, table, id})
  end

  @spec delete(atom(), term()) :: :ok | {:error, term()}
  def delete(table, id) do
    GenServer.call(@server, {:delete, table, id})
  end

  @spec drop(atom()) :: :ok
  def drop(table) do
    GenServer.call(@server, {:drop, table}) 
  end
end
