defmodule VerseGuess.Bible do

  @http_client Application.get_env(:verse_guess, :http_client)
  @random_verse_url Application.get_env(:verse_guess, :random_verse_url)
  
  @old_testament_books ["rdz","wj","kpl","lb","pwt","joz","sdz","rt","1sm","2sm","1krl","2krl","1krn","2krn","ezd","ne","est","hi","ps","prz","kaz","pnp","iz","jr","lm","ez","dn","oz","jl","am","ab","jon","mi","na","ha","so","ag","za","ml"]
  @old_testament_sections ["Prawo", "Pisma", "Prorocy"]
  @law_books ["rdz","wj","kpl","lb","pwt"]
  @writings_books ["joz","sdz","rt","1sm","2sm","1krl","2krl","1krn","2krn","ezd","ne","est","hi","ps","prz","kaz","pnp"]
  @prophets_books ["iz","jr","lm","ez","dn","oz","jl","am","ab","jon","mi","na","ha","so","ag","za","ml"]

  @new_testament_books ["mt","mk","lk","j","dz","rz","1kor","2kor","ga","ef","flp","kol","1tes","2tes","1tm","2tm","tt","flm","hbr","jb","1p","2p","1j","2j","3j","jud","obj"]
  @new_testament_sections ["Ewangelie", "Dzieje Apostolskie", "Listy", "Objawienie"]
  @gospels_books ["mt","mk","lk","j"]
  @letters_books ["rz","1kor","2kor","ga","ef","flp","kol","1tes","2tes","1tm","2tm","tt","flm","hbr","jb","1p","2p","1j","2j","3j","jud"]
  
  @doc """
  
  ## Examples

    iex> VerseGuess.Bible.get_random_verse()
    %{
        encoded_book_name: "ab", 
        chapter_number: 1, 
        verse_number: 14, 
        verse_text: "Nie powinieneś był stać na rozstaju dróg, aby wytracić tych, którzy uciekali, ani wydać tych, którzy pozostali spośród nich w dniu ucisku.",
        max_chapters: 1,
        max_verses: 21,
        possible_answers: [
            {:testament, "Testament", ["Stary Testament", "Nowy Testament"], 0},
            {:section, "Dział", ["Prawo", "Pisma", "Prorocy"], 2},
            {:book, "Księga", ["iz","jr","lm","ez","dn","oz","jl","am","ab","jon","mi","na","ha","so","ag","za","ml"], 8},
            {:verse, "Werset", ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21"], 13}
        ]
    }

  """
  def get_random_verse() do
    {:ok, %{body: body}} = @http_client.get(@random_verse_url)
    parsed = Poison.Parser.parse!(body, %{})
    verse = %{
      encoded_book_name: Map.get(parsed, "book"),
      chapter_number: Map.get(parsed, "chapter_number"),
      verse_number: Map.get(parsed, "verse_number"),
      verse_text: Map.get(parsed, "verse_text"),
      max_chapters: Map.get(parsed, "max_chapters"),
      max_verses: Map.get(parsed, "max_verses"),
    }
    Map.put(verse, :possible_answers, build_possible_answers(verse))
  end

  def build_possible_answers(verse) do
    testament = get_testament(verse)
    [testament | get_section(verse, testament)]
  end

  defp get_testament(verse) do
    book = Map.get(verse, :encoded_book_name)
    testament_index = case Enum.find(@new_testament_books, &(&1 == book)) do
                        nil -> 0 # Old Testament
                        _ -> 1 # New Testament
                      end
    {:testament, "Testament", ["Stary Testament", "Nowy Testament"], testament_index}
  end

  defp get_section(verse, {_, _, _, 0} = testament) do # for Old Testament
    book = Map.get(verse, :encoded_book_name)
    section_index =  case Enum.find_index(@old_testament_books, &(&1 == book)) do
                       x when x < length(@law_books) -> 0
                       x when x < length(@law_books) + length(@writings_books) -> 1
                       _ -> 2
                     end
    section = {:section, "Dział", @old_testament_sections, section_index}
    [section | get_book(verse, testament, section)]
  end

  defp get_section(verse, {_, _, _, 1}) do # for New Testament
    book = Map.get(verse, :encoded_book_name)
    section_index = case Enum.find_index(@new_testament_books, &(&1 == book)) do
                      x when x < length(@gospels_books) -> 0
                      x when x == 4 -> 1 # Acts of apostoles
                      x when x < 4 + length(@letters_books) -> 2
                      _ -> 3
                    end
    {:section, "Dział", @new_testament_sections, section_index}
  end

  defp get_book(verse, {_, _, _, 0}, {_, _, _, 0}) do # Law
    book = Map.get(verse, :encoded_book_name)
    book_index = Enum.find_index(@law_books, &(&1 == book))
    [{:book, "Księga", @law_books, book_index} | get_chapter(verse)]
  end

  defp get_book(verse, {_, _, _, 0}, {_, _, _, 1}) do # Writings
    book = Map.get(verse, :encoded_book_name)
    book_index = Enum.find_index(@writings_books, &(&1 == book))
    [{:book, "Księga", @writings_books, book_index} | get_chapter(verse)]
  end

  defp get_book(verse, {_, _, _, 0}, {_, _, _, 2}) do # Prophets
    book = Map.get(verse, :encoded_book_name)
    book_index = Enum.find_index(@prophets_books, &(&1 == book))
    [{:book, "Księga", @prophets_books, book_index} | get_chapter(verse)]
  end

  defp get_chapter(verse) do
    max_chapters = Map.get(verse, :max_chapters)
    case max_chapters do
      1 -> get_verse(verse)
      _ ->
        chapter_number = Map.get(verse, :chapter_number)
        chapters = for x <- 1..max_chapters, do: Integer.to_string(x)
        [{:chapter, "Rozdział", chapters, chapter_number - 1} | get_verse(verse)]
    end
  end

  defp get_verse(verse) do
    max_verses = Map.get(verse, :max_verses)
    verse_number = Map.get(verse, :verse_number)
    verses = for x <- 1..max_verses, do: Integer.to_string(x)
    [{:verse, "Werset", verses, verse_number - 1}]
  end
  
end
