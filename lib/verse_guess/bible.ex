defmodule VerseGuess.Bible do

  @http_client Application.get_env(:verse_guess, :http_client)
  @random_verse_url Application.get_env(:verse_guess, :random_verse_url)

  @doc """
  
  ## Examples

    iex> VerseGuess.Bible.get_random_verse()
    :ok

  """
  def get_random_verse() do
    _result = @http_client.get(@random_verse_url)
    :ok
  end
  
end
