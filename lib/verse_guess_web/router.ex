defmodule VerseGuessWeb.Router do
  use VerseGuessWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", VerseGuessWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/player-name", PageController, :set_player_name

    get "/game/start", GameController, :new
    get "/game/round", GameController, :round
    post "/game/answer/:answer_index", GameController, :answer

    get "/user", UserController, :new
    post "/user", UserController, :create

    get "/login", UserController, :login_form
    post "/login", UserController, :login
  end

  # Other scopes may use custom stacks.
  # scope "/api", VerseGuessWeb do
  #   pipe_through :api
  # end
end
