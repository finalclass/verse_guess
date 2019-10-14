defmodule VerseGuessWeb.UserController do
  use VerseGuessWeb, :controller
  alias VerseGuess.User

  def new(conn, _params) do
    conn
    |> assign(:errors, %{})
    |> render("new_form.html")
  end

  def create(conn, params) do
    conn |> handle_registration_validation(params, User.validate_register(params))
  end

  defp handle_registration_validation(conn, params, :ok) do
    :ok = User.create_new(params["email"], params["password"])

    conn
    |> redirect(to: Routes.page_path(conn, :index))
  end

  defp handle_registration_validation(conn, _params, {:errors, errors}) do
    conn
    |> assign(:errors, errors)
    |> render("new_form.html")
  end

  def login_form(conn, _params) do
    conn |> render("login_form")
  end

  def login(conn, _params) do
    conn |> redirect(to: Routes.page_path(conn, :index))
  end
end
