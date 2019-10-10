defmodule VerseGuessWeb.UserController do
  use VerseGuessWeb, :controller
  alias VerseGuess.User

  def new(conn, _params) do
    conn
    |> assign(:errors, %{})
    |> render("new_form.html")
  end

  def create(conn, params) do
    case User.validate_register(params) do
      :ok ->
        # TODO create user
        params
        |> User.save()
        conn |> redirect(to: Routes.page_path(conn, :index))

      {:error, errors} ->
        conn
        |> assign(:errors, errors)
        |> render("new_form.html")
    end
  end

  def login_form(conn, _params) do
    conn |> render("login_form")
  end

  def login(conn, _params) do
    conn |> redirect(to: Routes.page_path(conn, :index))
  end
end
