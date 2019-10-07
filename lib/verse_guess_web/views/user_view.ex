defmodule VerseGuessWeb.UserView do
  use VerseGuessWeb, :view

  def form_group(errors, field, fun) do
    field_errors = get_field_errors(errors, field)
    errors_class = if length(field_errors) > 0, do: "error", else: ""

    ~e"""
    <div class="form-group <%= errors_class %>">
      <%= fun.() %>
      <%= Enum.map(field_errors, fn error -> %>
        <p class="error">
          <%= error %>
        </p>
      <% end) %>
    </div>
    """
  end

  defp get_field_errors(errors, field) do
    if Map.has_key?(errors, field),
      do: Map.get(errors, field),
      else: []
  end
end
