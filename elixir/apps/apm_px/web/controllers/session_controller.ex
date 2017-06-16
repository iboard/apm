defmodule ApmPx.SessionController do
  require Logger
  use ApmPx.Web, :controller

  def login(conn, params) do
    %{"user" => user, "role" => role} = params

    conn 
      |> set_session_cookies(user,role)
      |> redirect to: "/"
  end

  def logout(conn,_params) do
    conn
      |> delete_session_cookies
      |> redirect to: "/"
  end


  # Private helpers -------------------------------------------------

  defp set_session_cookies(conn,user,role) do
    secs_to_live = 3600 * 24 * 7

    conn 
      |> put_resp_cookie("user", user, max_age: secs_to_live)
      |> put_resp_cookie("role", role, max_age: secs_to_live)
  end

  defp delete_session_cookies(conn) do
    conn
    |> delete_resp_cookie("user")
    |> delete_resp_cookie("role")
  end

end

