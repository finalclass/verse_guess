# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :verse_guess, VerseGuessWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "I4tSvjQmcU6C0BcIYvinLsE2bVLa2PHghYh2E7vs1fknW1tZ9Kb/bgZBf9Thgoom",
  render_errors: [view: VerseGuessWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: VerseGuess.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :verse_guess, :random_verse_url, "http://ubg.cienieprzyszlosci.pl/random"
config :verse_guess, :http_client, HTTPoison

config :verse_guess, :db, VerseGuess.Db
config :verse_guess, :users_table, :users

config :sendgrid, api_key: "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"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
