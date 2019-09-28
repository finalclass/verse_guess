defmodule VerseGuessWeb.Controllers.User do
  use VerseGuessWeb, :controller

  def new(conn, _params) do
    conn |> render("new_form")
  end

  def create(conn, params) do
    conn |> redirect(to: Routes.page_path, :index)
  end
  
  def login_form(conn, params) do
    conn |> render("login_form")
  end
  
end
