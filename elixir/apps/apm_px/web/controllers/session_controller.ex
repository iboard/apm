defmodule ApmPx.SessionController do
  
  @moduledoc """
  Handling login, logout, and the session. By now the session is user/role only,
  stored in cookies.
  """
  use ApmPx.Web, :controller

  @doc """
  Get `user` and `role` from `params` and set cookies `user` and `role` 
  and redirct to /
  """
  def login(conn, params) do
    %{"user" => user, "role" => role} = params

    conn 
      |> set_session_cookies(user,role)
      |> redirect(to: "/")
  end

  @doc """
  Remove cookies `user` and `role` from session 
  and redirect to /
  """
  def logout(conn,_params) do
    conn
      |> delete_session_cookies
      |> redirect(to: "/")
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

