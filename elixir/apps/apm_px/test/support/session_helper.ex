defmodule ApmPx.SessionHelper do
  defmacro __using__(_opts) do
    quote do
      use ExUnit.Case
      use ApmPx.ConnCase, async: true
      use Hound.Helpers
      hound_session()

      defp select_role(role) do
        find_element(:css, "#role-selector option[value='#{role}']") |> click()
      end

      defp login_as(user, role) do
        navigate_to("http://localhost:4000")
        element = find_element(:name, "user")
        fill_field(element, user)
        select_role(role)
        submit_element(element)
      end

    end
  end
end

