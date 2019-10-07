defmodule VerseGuess.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # init_mnesia()
    # List all child processes to be supervised
    children = [
      # Start the endpoint when the application starts
      VerseGuessWeb.Endpoint
      # Starts a worker by calling: VerseGuess.Worker.start_link(arg)
      # {VerseGuess.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: VerseGuess.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    VerseGuessWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  # def init_mnesia, do: handle_mnesia_schema_creation(:mnesia.crearse_guess/te_schema([node()]))

  # def handle_mnesia_schema_creation({:error, {_, {:already_exists, _}}}),
  #   do: handle_mnesia_schema_creation(:ok)

  # def handle_mnesia_schema_creation(:ok) do
  #   :mnesia.start()
  #   VerseGuess.User.create_mnesia_table();
  # end
end
