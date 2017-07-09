defmodule ApmIssues.Adapter do

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

