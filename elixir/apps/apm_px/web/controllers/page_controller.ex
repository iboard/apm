defmodule ApmPx.PageController do
  @moduledoc """
  Web pages 

  - `/` index.html
  """

  use ApmPx.Web, :controller

  @doc """
  The start page
  """
  def index(conn, _params) do
    render conn, "index.html"
  end
end
