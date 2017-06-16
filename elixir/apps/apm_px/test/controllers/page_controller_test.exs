defmodule ApmPx.PageControllerTest do
  require Logger
  use ApmPx.ConnCase

  test "GET / prints a welcome message", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to APM"
  end

  test "GET / when not logged in", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "You&#39;re not logged in"
  end

  test "GET / when logged in", %{conn: conn} do
    session = 
      conn
      |> put_resp_cookie("user", "some user")
      |> put_resp_cookie("role", "some role")
      |> get( "/" )
    assert html_response(session, 200) =~ "You&#39;re logged in"
  end


end
