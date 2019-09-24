defmodule VerseGuess.HttpClient do
  @book Application.get_env(:verse_guess, :http_client_response_book) 
  @chapter_number Application.get_env(:verse_guess, :http_client_response_chapter_number)
  @verse_number Application.get_env(:verse_guess, :http_client_response_verse_number)
  @verse_text Application.get_env(:verse_guess, :http_client_response_verse_text)

  def get(url) do
    {:ok,
     %HTTPoison.Response{
       body: """
       {"book":"#{@book}","chapter_number":#{@chapter_number},"verse_number":#{@verse_number},"verse_text":"#{@verse_text}","max_chapters":1,"max_verses":21}
       """,
       headers: [],
       request: %HTTPoison.Request{
         body: "",
         headers: [],
         method: :get,
         options: [],
         params: %{},
         url: url
       },
       status_code: 200,
       request_url: url
     }}
  end
end
