defmodule VerseGuess.Player do
  use GenServer

  ##########################
  # Public API
  ##########################
  
  def start_link(name) do
    GenServer.start_link(__MODULE__, %{name: name, points: 0})
  end

  def init(init_arg), do: {:ok, init_arg}

  def get_name(player_pid) do
    GenServer.call(player_pid, {:get_name})
  end

  def add_point(player_pid) do
    GenServer.call(player_pid, {:add_point})
  end

  def get_points(player_pid) do
    GenServer.call(player_pid, {:get_points})
  end

  ##########################
  # Handlers
  ##########################

  def handle_call({:get_name}, _from, state) do
    {:reply, Map.get(state, :name), state}
  end

  def handle_call({:add_point}, _from, state) do
    score = Map.get(state, :points)
    state = Map.put(state, :points, score + 1)
    {:reply, :ok, state}
  end

  def handle_call({:get_points}, _from, state) do
    {:reply, Map.get(state, :points), state}
  end

  ##########################
  # Private
  ##########################
  
end
