defmodule ApmPx.IssuesView do
  use ApmPx.Web, :view
  alias ApmIssues.{Repository}


  def render_issues_index(_conn) do
    Repository.all
    |> Enum.map( fn(pid) -> render_issue(pid) end)
  end

  def render_children(parent_pid) do
    ApmIssues.Issue.children(parent_pid)
    |> Enum.map( fn(pid) -> render_issue(pid) end)
  end

  defp render_issue({pid, id}) do
    issue = ApmIssues.Issue.state({pid, id})
    render("_issue_index.html", pid: pid, issue: issue)
  end
end
