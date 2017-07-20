defmodule ApmPx.IssueControllerTest do
  require Logger
  use ApmPx.ConnCase
  use TestHelper

  test "GET /issues lists all issues", %{conn: conn} do
    session = conn 
              |> login_as("some user", "admin") 
              |> get( "/issues" )
    assert html_response(session, 200) =~ "Item Number One"
    assert html_response(session, 200) =~ "Item Number Two With Children"
  end

  test "GET /issues when not logged in shows error", %{conn: conn} do
    conn = get conn, "/issues"
    assert html_response(conn, 200) =~ "Please login first"
  end

  test "GET /issues/item-2 renderes only item-2 with children", %{conn: conn} do
    session = conn 
              |> login_as("some user", "admin") 
              |> get( "/issues/Item-2" )
    refute html_response(session, 200) =~ "Item Number One"
    assert html_response(session, 200) =~ "Item Number Two With Children"
    assert html_response(session, 200) =~ "Son of item 1"
    assert html_response(session, 200) =~ "Daughter of item 1"
  end

  test "GET /issues/new renders 'new issue form'", %{conn: conn} do
    session = conn 
              |> login_as("some user", "admin") 
              |> get( "/issues/new" )
    assert html_response(session, 200) =~ "Create New Issue"
    assert html_response(session, 200) =~ "Subject"
    assert html_response(session, 200) =~ "Description"
    assert html_response(session, 200) =~ "Submit"
  end

  test "POST /issues creates a new issue", %{conn: conn} do
    conn 
    |> login_as("some user", "admin") 
    |> post( "/issues", subject: "New Issue", description: "Some text" )

    issue = ApmIssues.Repository.find_by_id("New-Issue")
    assert ApmIssues.Issue.state(issue).id == "New-Issue"
    assert ApmIssues.Issue.state(issue).subject == "New Issue"
    assert ApmIssues.Issue.state(issue).options == %{"description" => "Some text"}
  end



end
