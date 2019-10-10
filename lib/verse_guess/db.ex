defmodule VerseGuess.Db do
  @server __MODULE__.Server

  def start_link() do
    GenServer.start_link(@server, %{}, name: @server)
  end

  @spec save(atom(), tuple()) :: :ok | {:error, term()}
  def save(table, fields) do
    GenServer.call(@server, {:save, table, fields})
  end

  @spec get(atom(), term()) :: tuple()
  def get(table, id) do
    GenServer.call(@server, {:get, table, id})
  end
end
