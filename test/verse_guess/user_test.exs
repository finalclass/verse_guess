defmodule VerseGuess.UserTest do
  use ExUnit.Case
  alias VerseGuess.User

  @db Application.get_env(:verse_guess, :db)
  @table Application.get_env(:verse_guess, :users_table) 

  setup do
    @db.drop(@table);
    {:ok, []}
  end
  
  test "missing email is reported" do
    {:error, errors} = User.validate_register(%{})
    assert is_list(errors.email)
    assert length(errors.email) > 1
  end

  test "short email is reported" do
    {:error, errors} = User.validate_register(%{"email" => "abc"})

    assert Enum.any?(errors.email, &String.contains?(&1, "long"))
  end

  test "provided email must be email" do
    {:error, errors} = User.validate_register(%{"email" => "abc"})
    assert Enum.any?(errors.email, &String.contains?(&1, "@"))
  end

  test "password length" do
    {:error, errors} = User.validate_register(%{})
    assert is_list(errors.password)
    assert length(errors.password) >= 1
    assert Enum.any?(errors.password, &String.contains?(&1, "long"))
  end

  test "passwords must be the same" do
    {:error, errors} =
      User.validate_register(%{"password" => "abcdefg", "re_password" => "gggggg"})

    assert is_list(errors.re_password)
    assert length(errors.re_password) >= 1
    assert Enum.any?(errors.re_password, &String.contains?(&1, "same"))
  end

  test "passes when params are OK" do
    assert :ok ==
             User.validate_register(%{
               "email" => "test@example.com",
               "password" => "abcdefg",
               "re_password" => "abcdefg"
             })
  end

  test "saves and removes user" do
    result = User.create_new("test@example.com", "abcdef")
    assert result == :ok
    result = User.delete("test@examile.com")
    assert result == :ok
  end

end
