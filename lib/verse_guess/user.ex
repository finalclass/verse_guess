defmodule VerseGuess.User do
  @type errors :: %{atom => [String.t()]}
  @type register_params :: %{email: String.t(), password: String.t(), re_password: String.t()}

  @spec validate_register(register_params) :: :ok | {:error, errors}
  def validate_register(params) do
    errors =
      %{email: [], password: [], re_password: []}
      |> validate_email_length(params["email"])
      |> validate_email_at_sign(params["email"])
      |> validate_password_length(params["password"])
      |> validate_passwords_are_same(params["password"], params["re_password"])

    IO.inspect(errors)
    
    if errors_empty?(errors),
      do: :ok,
      else: {:error, errors}
  end

  @spec errors_empty?(errors) :: boolean
  defp errors_empty?(errors), do: Enum.all?(errors, fn {k, v} -> length(v) == 0 end)

  @spec add_error(errors, atom, String.t()) :: errors
  defp add_error(errors, key, new_error) do
    Map.put(errors, key, [new_error | Map.get(errors, key)])
  end

  @spec validate_password_length(errors, String.t()) :: errors
  defp validate_password_length(errors, password) do
    if String.length(password) < 4,
      do: add_error(errors, :password, "password must be at least 4 characters long"),
      else: errors
  end

  @spec validate_passwords_are_same(errors, String.t(), String.t()) :: errors
  defp validate_passwords_are_same(errors, password, re_password) when password != re_password,
    do: add_error(errors, :re_password, "repeated password must be the same")

  defp validate_passwords_are_same(errors, password, re_password), do: errors

  @spec validate_email_at_sign(errors, String.t()) :: errors
  defp validate_email_at_sign(errors, email) do
    if String.contains?(email, "@"),
      do: errors,
      else: add_error(errors, :email, "email must contain '@' sign")
  end

  @spec validate_email_length(errors, String.t()) :: errors
  defp validate_email_length(errors, email) do
    if String.length(email) < 6,
      do: add_error(errors, :email, "email is too short"),
      else: errors
  end
end
