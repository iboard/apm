defmodule ApmPx.IssuesControllerTest do
  require Logger
  use ApmPx.ConnCase

  test "GET /issues lists loaded issues when logged in", %{conn: conn} do
    session = conn 
                |> TestHelper.login_as("some user", "admin") 
                |> get( "/issues" )
    assert html_response(session, 200) =~ "Item Number One"
  end

end

