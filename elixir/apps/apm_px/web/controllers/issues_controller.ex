defmodule ApmPx.IssuesController do
  @moduledoc """
  Routes handled by this controller

  - `/issues` index.html
  """

  use ApmPx.Web, :controller

  @doc """
  The Issues index page
  """
  def index(conn, _params) do
    render conn, "index.html"
  end
end

