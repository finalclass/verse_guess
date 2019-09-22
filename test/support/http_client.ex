defmodule VerseGuess.HttpClient do
  def get(url) do
    {:ok,
     %HTTPoison.Response{
       body: """
       {"book":"ab","chapter_number":1,"verse_number":14,"verse_text":" Nie powinieneś był stać na rozstaju dróg, aby wytracić tych, którzy uciekali, ani wydać tych, którzy pozostali spośród nich w dniu ucisku. ","all_books":["rdz","wj","kpl","lb","pwt","joz","sdz","rt","1sm","2sm","1krl","2krl","1krn","2krn","ezd","ne","est","hi","ps","prz","kaz","pnp","iz","jr","lm","ez","dn","oz","jl","am","ab","jon","mi","na","ha","so","ag","za","ml","mt","mk","lk","j","dz","rz","1kor","2kor","ga","ef","flp","kol","1tes","2tes","1tm","2tm","tt","flm","hbr","jb","1p","2p","1j","2j","3j","jud","obj"],"max_chapters":1,"max_verses":21}
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
