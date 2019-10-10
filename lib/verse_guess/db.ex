defmodule VerseGuess.Db do

  @spec save(binary(), tuple()) :: :ok
  def save(table, fields) do
    ensure_table_exists()
    # :ets.tabl
  end

  @spec ensure_table_exists(atom()) :: :ok | :error
  defp ensure_table_exists(table) do
    case :dets.info(table) do
      :undefined ->
        {:ok, table} = handle_open_table(:dets.open_file(table, [type: :set]))
        :ok
      _ -> :ok
    end
  end

end
