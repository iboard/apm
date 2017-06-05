defmodule ApmPx.SessionView do
  use ApmPx.Web, :view

  def render_session(conn) do
    if logged_in? do
      render "_session.html", conn: conn
    else
      render "_login.html", conn: conn
    end
  end


  defp logged_in?, do: false
end

