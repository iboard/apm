defmodule ApmPx.SessionView do
  require Logger
  use ApmPx.Web, :view

  def render_session(conn) do
    session_user  = conn.cookies["user"]
    session_role  = conn.cookies["role"]

    if logged_in?(conn) do
      render "_session.html", conn: conn
    else
      render "_login.html", conn: conn
    end
  end

  def current_user_name(conn) do
    conn.cookies["user"] 
  end

  def current_user_role(conn) do
    conn.cookies["role"] 
  end

  defp logged_in?(conn) do
    conn.cookies["user"] && conn.cookies["role"]
  end
end

