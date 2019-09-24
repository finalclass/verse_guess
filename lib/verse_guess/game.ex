defmodule VerseGuess.Game do
  use GenServer

  alias VerseGuess.Bible

  ##########################
  # Public API
  ##########################
  
  def start_link() do
    GenServer.start_link(__MODULE__, %{
      players: [],
      book: "",
      chapter_number: 0,
      verse_number: 0,
      verse_text: ""
    })
  end

  def init(init_arg), do: {:ok, next_round(init_arg)}

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

  def next_stage(game_pid) do
    GenServer.call(game_pid, {:next_stage})
  end

  ##########################
  # Handlers
  ##########################
  
  def handle_call({:add_player, player_pid, player_name}, _from, state) do
    players = Map.get(state, :players)
    players = [{player_pid, player_name} | players]
    state = Map.put(state, :players, players)
    {:reply, :ok, state}
  end

  def handle_call({:get_players}, _from, state) do
    {:reply, Map.get(state, :players), state}
  end

  def handle_call({:get_verse_text}, _from, state) do
    verse_text = Map.get(state, :verse_text)
    {:reply, verse_text, state}
  end

  def handle_call({:get_options}, _from, state) do
    ans = Map.get(state, :possible_answers)
    stage = Map.get(state, :stage)
    options = elem(ans, stage)
    {:reply, options, state}
  end

  def handle_call({:next_stage}, _from, state) do
    current_stage = Map.get(state, :stage)
    possible_answers = Map.get(state, :possible_answers)
    state = state |> bump_stage_or_round(current_stage + 1, possible_answers)
    {:reply, :ok, state}
  end

  ##########################
  # Private functions
  ##########################
  
  defp bump_stage_or_round(state, next_stage, possible_answers)
       when next_stage > length(possible_answers),
       do: next_round(state)

  defp bump_stage_or_round(state, next_stage, _possible_answers),
    do: Map.put(state, :stage, next_stage)

  defp next_round(state) do
    verse = Bible.get_random_verse()

    state
    |> Map.put(:book, Map.get(verse, :encoded_book_name))
    |> Map.put(:chapter_number, Map.get(verse, :chapter_number))
    |> Map.put(:verse_number, Map.get(verse, :verse_number))
    |> Map.put(:verse_text, Map.get(verse, :verse_text))
    |> Map.put(:possible_answers, Map.get(verse, :possible_answers))
    |> Map.put(:stage, 0)
  end
end
