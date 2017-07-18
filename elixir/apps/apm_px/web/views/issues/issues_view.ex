defmodule ApmPx.IssuesView do
  use ApmPx.Web, :view
  
  alias ApmIssues.{Repository}

  @doc"""
  Render all root-issues recursively
  """
  def render_issues_index(_conn) do
    Repository.root_issues
    |> Enum.map( fn(pid) -> render_issue(pid) end)
  end
  defp render_issue({pid, id}) do
    issue = ApmIssues.Issue.state({pid, id})
    render("_issue_index.html", id: id, pid: pid, issue: issue)
  end

  @doc"""
  Render one issue recursively
  """
  def render_show_issue(conn) do
    params = conn.params
    item_id = params["id"]
    pid = Repository.find_by_id(item_id)
    issue = ApmIssues.Issue.state({pid, item_id})

    render("_issue_index.html", id: item_id, pid: pid, issue: issue)
  end


  @doc"""
  Render children of an issue recursively
  """
  def render_children(parent_pid) do
    ApmIssues.Issue.children(parent_pid)
    |> Enum.map( fn(pid) -> render_issue(pid) end)
  end

  @doc"""
  Render HTML-Form for issue.
  FIXME: changeset not used yet
  """
  def form(conn,changeset \\ %ApmIssues.Issue{} ) do
    render("_form.html", conn: conn, issue: changeset)
  end


end
