defmodule ApmPx.SessionController do
  require Logger
  use ApmPx.Web, :controller

  def login(conn, params) do
    Logger.info( inspect(params) )
    redirect conn, to: "/"
  end
end

