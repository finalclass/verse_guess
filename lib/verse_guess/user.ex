defmodule VerseGuess.User do
  import VerseGuess.Validators

  @db Application.get_env(:verse_guess, :db)
  @table Application.get_env(:verse_guess, :users_table)

  @type errors :: VerseGuess.Validators.errors()
  @type params :: %{String.t() => [String.t()]}

  @spec validate_register(params) :: :ok | {:error, errors}
  def validate_register(params) do
    %{}
    |> validate_min_length(params, "email", 6)
    |> validate_email(params, "email")
    |> validate_email_not_used(params["email"])
    |> validate_min_length(params, "password", 4)
    |> validate_passwords_equal(params, "password", "re_password")
    |> validation_response()
  end

  @spec save(params) :: :ok
  def save(params) do
    @db.save(@table, {params["email"], params["password"]})
  end

  @spec delete(binary()) :: :ok
  def delete(email) do
    @db.delete(@table, email)
  end

  @spec validate_email_not_used(errors, binary()) :: errors
  defp validate_email_not_used(errors, email) do
    case @db.get(@table, email) do
      nil -> errors
      _ -> add_error(errors, :email, "User with that email address arleady exists")
    end
  end
end
