defmodule VerseGuess.Game do
  use GenServer

  alias VerseGuess.Bible

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

  def get_verse_text(game_pid) do
    GenServer.call(game_pid, {:get_verse_text})
  end

  def get_options(game_pid) do
    GenServer.call(game_pid, {:get_options})
  end

  def next_guess(game_pid) do
    GenServer.call(game_pid, {:next_guess})
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
    verse = Bible.get_random_verse()
    verse_text = Map.get(verse, :verse_text)
    state = state
    |> Map.put(:book, Map.get(verse, :encoded_book_name))
    |> Map.put(:chapter_number, Map.get(verse, :chapter_number))
    |> Map.put(:verse_number, Map.get(verse, :verse_number))
    |> Map.put(:verse_text, verse_text)
    |> Map.put(:possible_answers, Map.get(verse, :possible_answers))

    {:reply, verse_text, state}
  end

  def handle_call({:get_verse_text}, _from, state) do
    verse_text = Map.get(state, :verse_text)
    {:reply, verse_text, state}
  end

  def handle_call({:get_options}, _from, state) do
    ans = Map.get(state, :possible_answers)
    {:reply, ans, state}
  end

  def handle_call({:next_guess}, _from, state) do
    state = Map.put(state, :possible_answers, ["Prawo", "Pisma", "Prorocy"])
    {:reply, :ok, state)
  end
end
