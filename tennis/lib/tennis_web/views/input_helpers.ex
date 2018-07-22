# http://blog.plataformatec.com.br/2016/09/dynamic-forms-with-phoenix/
defmodule TennisWeb.InputHelpers do
  use Phoenix.HTML

  def admin_link(current_user, href, text, classes \\ []) do
    if current_user.role in ["admin"] do
      ~E"""
        <a class="<%= Enum.join(classes, " ") %>" href="<%= href %>"><%= text %></a>
      """
    end
  end

  def input(form, field, opts \\ []) do
    type = opts[:using] || Phoenix.HTML.Form.input_type(form, field)

    wrapper_opts = [class: "form-group #{state_class(form, field)}"]
    input_opts = [class: "form-control"]

    content_tag :div, wrapper_opts do
      label = label(form, field, humanize(field))

      content =
        content_tag :div do
          input = input(type, form, field, input_opts)
          error = TennisWeb.ErrorHelpers.error_tag(form, field)
          [input, error || ""]
        end

      [label, content]
    end
  end

  def state_class(form, field) do
    cond do
      # The form was not yet submitted
      !form.source.action ->
        ""

      form.errors[field] ->
        "has-error"

      true ->
        "has-success"
    end
  end

  # Implement clauses below for custom inputs.
  # defp input(:datepicker, form, field, input_opts) do
  #   raise "not yet implemented"
  # end

  defp input(type, form, field, input_opts) do
    apply(Phoenix.HTML.Form, type, [form, field, input_opts])
  end
end
