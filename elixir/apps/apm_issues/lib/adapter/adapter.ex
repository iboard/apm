defmodule ApmIssues.Adapter do

  @doc"""
  Issues is a list of structures going to be pushed to the
  repository. The function returns a list of PIDs
  """
  def push issues do
    issues
    |> Enum.map( fn(issue) ->
      push_item(issue)
    end)
  end

  defp push_item( struct ) do
    pid = ApmIssues.Issue.new(struct)
    ApmIssues.Repository.push(pid)
    pid
  end

end

