Application.ensure_all_started(:hound)
ExUnit.start

defmodule TestHelper do
  defmacro __using__(_opts) do
    quote do
      defp login_as(conn, user,role) do
        conn
        |> put_resp_cookie("user", user)
        |> put_resp_cookie("role", role)
      end
    end
  end

end
