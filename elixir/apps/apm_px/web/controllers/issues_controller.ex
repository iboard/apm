defmodule ApmPx.IssuesController do
  require Logger

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

  @doc """
  Show one issue with children
  """
  def show(conn, _params) do
    render conn, "show.html"
  end

  @doc """
  Show form for new Issue
  """
  def new(conn, _params) do
    render conn, "new.html"
  end
  
  @doc """
  POST /issues Creates a new issue
  """
  def create(conn, params) do
    {id,subject,options} = cast(params)
    ApmIssues.Issue.new( id, subject, options )
    redirect conn, to: "/issues/#{id}"
  end

  defp cast(params) do
    subject = params["subject"]
    id = make_id(subject)
    options = Map.drop(params, ["_csrf_token","_utf8","subject"])
    {id,subject,options}
  end

  defp make_id(string) do
    String.replace(string," ","-")
  end
end

