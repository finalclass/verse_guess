defmodule VerseGuess.User do
  import VerseGuess.Validators

  @type errors :: VerseGuess.Validators.errors()
  @type params :: %{String.t() => [String.t()]}

  @spec validate_register(params) :: :ok | {:error, errors}
  def validate_register(params) do
    %{}
    |> validate_min_length(params, "email", 6)
    |> validate_email(params, "email")
    |> validate_min_length(params, "password", 4)
    |> validate_passwords_equal(params, "password", "re_password")
    |> validation_response()
  end
end
