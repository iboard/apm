defmodule ApmPx.SessionView do
  require Logger
  use ApmPx.Web, :view


  @doc """
  Renders the partial for the sessions section on the front-end.
  If user is logged in, it renders "_session.html" otherwise "_login.html".
  Where sessions.html shows information of the currently logged in user
  and login.html renders the form to login.
  """
  def render_session(conn) do
    if logged_in?(conn) do
      render "_session.html", conn: conn
    else
      render "_login.html", conn: conn
    end
  end

  @doc """
  Fetch user name from cookies
  """
  def current_user_name(conn) do
    conn.cookies["user"] 
  end

  @doc """
  Fetch the role of the currently logged in user from cookies
  """
  def current_user_role(conn) do
    conn.cookies["role"] 
  end

  @doc """
  A user is logged in when both cookies, user and role, exists.
  """
  def logged_in?(conn) do
    current_user_name(conn) && current_user_role(conn)
  end

  @doc """
  Render the partial for role-selection
  """
  def roles_selection(conn) do
    render "_roles_selection.html", conn: conn
  end

  @doc """
  Renders an html-option for each defined role.
  Role's key and name comes from OTP application ApmUser
  and role is translated using gettext
  """
  def role_options do
    ApmUser.roles 
      |> Enum.map( fn(role) -> 
           role_option(role) 
         end )
      |> Enum.join("\n")
      |> raw
  end

  defp role_option(role) do
    translated = Gettext.gettext(ApmPx.Gettext, role.name)
    "<option value='#{role.key}'>#{translated}</option>"
  end
end

