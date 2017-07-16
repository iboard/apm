defmodule ApmPx.HoundBasicTests do
  use ApmPx.SessionHelper

  @logged_in_message  "You're logged in as 'hound user' in the role of a 'developer'"
  @logged_out_message "You're not logged in!"

  describe "E2E - Login/Logout" do

    @tag :hound
    test "Simple Login without authentication (by now, we trust our users)" do

      # Given
      navigate_to("http://localhost:4000")
      element = find_element(:name, "user")

      # When
      fill_field(element, "hound user")
      select_role("developer")
      submit_element(element)

      # Then
      assert visible_text({:id, "login-state"}) == @logged_in_message
    end


    @tag :hound
    test "Log out clears user and role cookie" do

      # Given (logged with user and role)
      navigate_to("http://localhost:4000")
      element = find_element(:name, "user")
      fill_field(element, "hound user")
      select_role("developer")
      submit_element(element)
      assert visible_text({:id, "login-state"}) == @logged_in_message

      # When
      logout = find_element(:id, "logout")
      click(logout)

      # Then
      assert visible_text({:id, "login-state"}) == @logged_out_message
    end

  end

end
