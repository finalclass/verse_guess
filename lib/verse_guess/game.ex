defmodule VerseGuess.Game do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, %{
          players: [],
          book: "",
          chapter_number: 0,
          verse_number: 0,
          verse_text: ""
    })
  end

  def init(init_arg), do: {:ok, init_arg}

  def new_round(game_pid) do
    GenServer.call(game_pid, {:new_round})
  end
  
  def get_players(game_pid) do
    GenServer.call(game_pid, {:get_players})
  end
  
  def add_player(game_pid, player_pid, player_name) do
    GenServer.call(game_pid, {:add_player, player_pid, player_name})
  end

  def handle_call({:add_player, player_pid, player_name}, _from, state) do
    players = Map.get(state, :players)
    players = [{player_pid, player_name} | players]
    state = Map.put(state, :players, players)
    {:reply, :ok, state}
  end

  def handle_call({:get_players}, _from, state) do
    {:reply, Map.get(state, :players), state}
  end

  def handle_call({:new_round}, _from, state) do
    verse_text = "Na początku było Słowo a Słowo było u Boga i Bogiem było Słowo"
    state = state
    |> Map.put(:book, "jn")
    |> Map.put(:chapter_number, 1)
    |> Map.put(:verse_number, 1)
    |> Map.put(:verse_text, verse_text)

    {:reply, verse_text, state}
  end
end
