defmodule ApmPx.PageControllerTest do
  use ApmPx.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to APM"
  end

  test "GET / when not logged in", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "You're not logged in"
  end
end
