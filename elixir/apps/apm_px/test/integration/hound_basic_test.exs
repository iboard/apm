defmodule ApmPx.HoundBasicTests do
  use ExUnit.Case
  use Hound.Helpers

  hound_session()


  @tag :hound
  test "the landing page with hound" do
    navigate_to("http://localhost:4000")
    take_screenshot()
    element = find_element(:name, "user")
    IO.inspect element
    #fill_field(element, "hound user")
    #submit_element(element)

    assert page_title() == "APM - Index"
  end

end
