defmodule ApmIssues.AdapterTest do
  use ExUnit.Case

  doctest ApmIssues.Adapter.File

  @fixture_file Path.expand("../../../data/fixtures/issues.json", __DIR__)

  test "Fixture file exists" do
    File.exists?(@fixture_file)
  end

  test "Read Items from file" do
    [first,_] = ApmIssues.Adapter.File.read!(@fixture_file)
    assert ApmIssues.Issue.state(first).id == "Item-1"
    assert ApmIssues.Issue.state(first).subject == "Item Number One"
  end

  test "Read with children" do
    [_first,second] = ApmIssues.Adapter.File.read!(@fixture_file)
    [daughter,son]  = ApmIssues.Issue.children(second)

    assert ApmIssues.Issue.state(son).id == "Item-2.1"
    assert ApmIssues.Issue.state(daughter).id == "Item-2.2"
  end

  test "Read into repository" do
    ApmIssues.Adapter.File.read!(@fixture_file)
    |> ApmIssues.Adapter.push

    pid = ApmIssues.Repository.find_by_id("Item-1")
    assert ApmIssues.Issue.state(pid).id == "Item-1"
    assert ApmIssues.Issue.state(pid).subject == "Item Number One"
  end
end

