use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :verse_guess, VerseGuessWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :verse_guess, :http_client, VerseGuess.HttpClient
config :verse_guess, :http_client_response_book, "ab"
config :verse_guess, :http_client_response_chapter_number, 1
config :verse_guess, :http_client_response_verse_number, 14
config :verse_guess, :http_client_response_verse_text, "Nie powinieneś był stać na rozstaju dróg, aby wytracić tych, którzy uciekali, ani wydać tych, którzy pozostali spośród nich w dniu ucisku."
