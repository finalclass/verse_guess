defmodule VerseGuess.Bible do

  @http_client Application.get_env(:verse_guess, :http_client)
  @random_verse_url Application.get_env(:verse_guess, :random_verse_url)

  @doc """
  
  ## Examples

    iex> VerseGuess.Bible.get_random_verse()
    %{
        encoded_book_name: "ab", 
        chapter_number: 1, 
        verse_number: 14, 
        verse_text: "Nie powinieneś był stać na rozstaju dróg, aby wytracić tych, którzy uciekali, ani wydać tych, którzy pozostali spośród nich w dniu ucisku."
    }

  """
  def get_random_verse() do
    {:ok, %{body: body}} = @http_client.get(@random_verse_url)
    parsed = Poison.Parser.parse!(body, %{})
    %{
      encoded_book_name: Map.get(parsed, "book"),
      chapter_number: Map.get(parsed, "chapter_number"),
      verse_number: Map.get(parsed, "verse_number"),
      verse_text: Map.get(parsed, "verse_text")
    }
  end
  
end
