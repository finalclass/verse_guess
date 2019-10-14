defmodule VerseGuess.Mailer do
  @spec send_mail(binary(), %{String.t() => [String.t()]}) :: :ok | {:error, [String.t()]} | {:error, String.t()}
  def send_mail(_template, _vars) do
    email =
      SendGrid.Email.build()
      |> SendGrid.Email.put_from("test@email.com")
      |> SendGrid.Email.add_to("s@finalclass.net")
      |> SendGrid.Email.put_subject("Hello from Elixir")
      |> SendGrid.Email.put_html("<html><body><p>Sent from Elixir!</p></body></html>")

    SendGrid.Mail.send(email)
  end
end
