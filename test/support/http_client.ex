defmodule VerseGuess.HttpClient do
  @book Application.get_env(:verse_guess, :http_client_response_book) 
  @chapter_number Application.get_env(:verse_guess, :http_client_response_chapter_number)
  @verse_number Application.get_env(:verse_guess, :http_client_response_verse_number)
  @verse_text Application.get_env(:verse_guess, :http_client_response_verse_text)
  
  def get(url) do
    {:ok,
     %HTTPoison.Response{
       body: """
       {"book":"#{@book}","chapter_number":#{@chapter_number},"verse_number":#{@verse_number},"verse_text":"#{@verse_text}","all_books":["rdz","wj","kpl","lb","pwt","joz","sdz","rt","1sm","2sm","1krl","2krl","1krn","2krn","ezd","ne","est","hi","ps","prz","kaz","pnp","iz","jr","lm","ez","dn","oz","jl","am","ab","jon","mi","na","ha","so","ag","za","ml","mt","mk","lk","j","dz","rz","1kor","2kor","ga","ef","flp","kol","1tes","2tes","1tm","2tm","tt","flm","hbr","jb","1p","2p","1j","2j","3j","jud","obj"],"max_chapters":1,"max_verses":21}
       """,
       headers: [],
       request: %HTTPoison.Request{
         body: "",
         headers: [],
         method: :get,
         options: [],
         params: %{},
         url: "http://ubg.cienieprzyszlosci.pl/random"
       },
       status_code: 200,
       request_url: "http://ubg.cienieprzyszlosci.pl/random"
     }}
  end
end
