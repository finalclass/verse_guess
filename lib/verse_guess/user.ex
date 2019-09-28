defmodule VerseGuess.User do

  def create_mnesia_table do
    case :mnesia.create_table(:user, [attributes: [:login, :password], disc_copies: [node()]]) do
      {:atomic, :ok} ->
        :ok
      {:aborted, {:already_exists, :user}} ->
        case :mnesia.table_info(:user, :attributes) do
          [:login, :password] -> :ok
          other ->
            {:error, other}
        end
    end
  end

  
  
end
