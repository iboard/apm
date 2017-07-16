defmodule ApmPx.E2EIssuesTest do
  use ApmPx.SessionHelper

  describe "E2E Issues" do

    @tag :hound
    test "GET /issues lists loaded issues when logged in" do
      login_as("user", "developer")

      navigate_to("http://localhost:4000/issues")
      assert visible_text({:id, "issues"}) =~ "Item Number One"
      assert visible_text({:id, "issues"}) =~ "Item Number Two"
      assert visible_text({:id, "issues"}) =~ "Daughter of item 1"
      assert visible_text({:id, "issues"}) =~ "Son of item 1"
    end

    @tag :hound
    test "GET /issues when not logged in shows error" do
      navigate_to("http://localhost:4000/issues")
      assert visible_text({:class, "error"}) =~ "Please login first"
      refute visible_page_text() =~ "Item Number One"
    end
  end

end
