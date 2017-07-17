defmodule ApmPx.IssuesView do
  use ApmPx.Web, :view
  alias ApmIssues.{Repository}


  def render_issues_index(_conn) do
    Repository.root_issues
    |> Enum.map( fn(pid) -> render_issue(pid) end)
  end

  def render_show_issue(conn) do
    params = conn.params
    item_id = params["id"]
    pid = Repository.find_by_id(item_id)
    issue = ApmIssues.Issue.state({pid, item_id})

    render("_issue_index.html", id: item_id, pid: pid, issue: issue)
  end

  def render_children(parent_pid) do
    ApmIssues.Issue.children(parent_pid)
    |> Enum.map( fn(pid) -> render_issue(pid) end)
  end

  defp render_issue({pid, id}) do
    issue = ApmIssues.Issue.state({pid, id})
    render("_issue_index.html", id: id, pid: pid, issue: issue)
  end
end
