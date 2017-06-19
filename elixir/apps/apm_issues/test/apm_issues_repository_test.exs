defmodule ApmIssuesRepositoryTest do
  use ExUnit.Case
  doctest ApmIssues.Repository
  alias ApmIssues.{Repository, Issue}

  setup do
    Repository.drop!
    issue1 = Issue.new(1, "Item One", %{state: :new})
    issue2 = Issue.new(2, "Item Two", %{state: :open})
    issue21 = Issue.new(2.1, "Item 2.1", %{state: :done})
    issue2 |> Issue.add_child(issue21)

    [issue1,issue2,issue21]
    |> Enum.each( fn issue ->
      Repository.push(issue)
    end)
    { :ok, %{ issues: [issue1, issue2, issue21] } }
  end

  test "Issues Repository gets started with the app" do
    assert 3 == ApmIssues.Repository.count() 
  end

  test "Find issues by id" do
    pid = Repository.find_by_id(1)
    assert %Issue{id: 1, title: "Item One", options: %{state: :new}} == Issue.state(pid)
  end

  test "Find not existing issue returns :not_found" do
    not_found = Repository.find_by_id(:nothing_here)
    assert not_found == :not_found
  end



end
