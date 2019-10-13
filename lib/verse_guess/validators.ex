defmodule VerseGuess.Validators do
  @type errors :: %{atom => [String.t()]}
  @type params :: %{String.t() => [String.t()]}

  @spec validation_response(errors) :: :ok | {:error, %{atom => [String.t()]}}
  def validation_response(errors) do
    if errors_empty?(errors),
      do: :ok,
      else: {:error, errors}
  end

  @spec validate_min_length(errors, params, String.t(), pos_integer()) :: errors
  def validate_min_length(errors, params, field, length) do
    if !is_binary(params[field]) or String.length(params[field]) < length do
      add_error(
        errors,
        field,
        field <> " must be at least " <> Integer.to_string(length) <> " characters long"
      )
    else
      errors
    end
  end

  @spec validate_passwords_equal(errors, params, String.t(), String.t()) :: errors
  def validate_passwords_equal(errors, params, password_field, re_password_field) do
    if is_binary(params[password_field]) and
         is_binary(params[re_password_field]) and
         params[password_field] == params[re_password_field] do
      errors
    else
      add_error(errors, re_password_field, "repeated password must be the same")
    end
  end

  @spec validate_email(errors, params, String.t()) :: errors
  def validate_email(errors, params, email_field) do
    if is_binary(params[email_field]) and String.contains?(params[email_field], "@"),
      do: errors,
      else: add_error(errors, email_field, "email must contain '@' sign")
  end

  @spec add_error(errors, atom | String.t(), String.t()) :: errors
  def add_error(errors, key, err_msg) when is_binary(key),
    do: add_error(errors, String.to_atom(key), err_msg)

  def add_error(errors, key, err_msg) when is_atom(key) do
    errors = ensure_error_key_exists(errors, key) 
    Map.put(errors, key, [err_msg | Map.get(errors, key)])
  end
  
  ######################
  # Private
  ######################

  @spec errors_empty?(errors) :: boolean
  defp errors_empty?(errors), do: Enum.all?(errors, fn {_k, v} -> length(v) == 0 end)

  

  @spec ensure_error_key_exists(errors, atom) :: errors
  defp ensure_error_key_exists(errors, key) do
    if Map.has_key?(errors, key),
      do: errors,
      else: Map.put(errors, key, [])
  end
end
