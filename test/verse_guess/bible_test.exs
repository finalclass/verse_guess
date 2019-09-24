defmodule VerseGuess.BibleTest do
  alias VerseGuess.Bible
  
  use ExUnit.Case
  doctest Bible

  setup do
    %{
      fixtures: [
        {
          %{
            encoded_book_name: "ab", 
            chapter_number: 1,
            verse_number: 14,
            max_chapters: 1,
            max_verses: 21
          },
          [
            {:testament, "Testament", ["Stary Testament", "Nowy Testament"], 0},
            {:section, "Dział", ["Prawo", "Pisma", "Prorocy"], 2},
            {:book, "Księga", ["iz","jr","lm","ez","dn","oz","jl","am","ab","jon","mi","na","ha","so","ag","za","ml"], 8},
            {:verse, "Werset", ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21"], 13}
          ]
        },
        {
          %{
            encoded_book_name: "wj",
            chapter_number: 3,
            verse_number: 10,
            max_chapters: 40,
            max_verses: 22
          },
          [
            {:testament, "Testament", ["Stary Testament", "Nowy Testament"], 0},
            {:section, "Dział", ["Prawo", "Pisma", "Prorocy"], 0},
            {:book, "Księga", ["rdz","wj","kpl","lb","pwt"], 1},
            {:chapter, "Rozdział", ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14",
 "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27",
 "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"], 2},
            {:verse, "Werset", ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21", "22"], 9}
          ]
        },
        {
          %{
            encoded_book_name: "prz",
            chapter_number: 20,
            verse_number: 10,
            max_chapters: 31,
            max_verses: 30
          },
          [
            {:testament, "Testament", ["Stary Testament", "Nowy Testament"], 0},
            {:section, "Dział", ["Prawo", "Pisma", "Prorocy"], 1},
            {:book, "Księga", ["joz","sdz","rt","1sm","2sm","1krl","2krl","1krn","2krn","ezd","ne","est","hi","ps","prz","kaz","pnp"], 14},
            {:chapter, "Rozdział", ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14",
 "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27",
 "28", "29", "30", "31"], 19},
            {:verse, "Werset", ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21", "22", "23", "24", "25", "26", "27",
 "28", "29", "30"], 9}
          ]
        }
      ]
    }
  end

  
  
  test "build_possible_answers", %{fixtures: fixtures} do
    Enum.each(fixtures, fn {verse, expected} ->
      possible_answers = Bible.build_possible_answers(verse)
      assert possible_answers == expected
    end)
  end
  
end
