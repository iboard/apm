Application.ensure_all_started(:hound)
ExUnit.start

defmodule TestHelper do
  use ApmPx.ConnCase, async: true

  def login_as(conn, user,role) do
    conn
    |> put_resp_cookie("user", user)
    |> put_resp_cookie("role", role)
  end
end

