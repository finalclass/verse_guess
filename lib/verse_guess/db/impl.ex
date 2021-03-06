defmodule VerseGuess.Db.Impl do
  @type reason :: term()

  @spec save(atom(), tuple()) :: :ok | {:error, term()}
  def save(table, fields) do
    :ok = ensure_table_exists(table)
    :dets.insert(table, fields)
  end

  @spec get(atom(), term()) :: tuple() | nil
  def get(table, id) do
    :ok = ensure_table_exists(table)

    case :dets.lookup(table, id) do
      [record | _] -> record
      _ -> nil
    end
  end

  @spec delete(atom(), term()) :: :ok | {:error, reason}
  def delete(table, id) do
    :dets.delete(table, id)
  end

  @spec drop(atom()) :: :ok
  def drop(table) do
    File.rm(Atom.to_string(table))
    :ok
  end

  @spec ensure_table_exists(atom()) :: :ok | :error
  defp ensure_table_exists(table) do
    case :dets.info(table) do
      :undefined ->
        {:ok, _} = :dets.open_file(table, type: :set)
        :ok

      _ ->
        :ok
    end
  end
end
