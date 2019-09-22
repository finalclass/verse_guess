defmodule VerseGuess.Player do

  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, %{name: name})
  end

  def init(init_arg), do: {:ok, init_arg}

  def get_name(player_pid) do
    GenServer.call(player_pid, {:get_name})
  end

  def handle_call({:get_name}, _from, state) do
    {:reply, Map.get(state, :name), state}
  end
  
end
