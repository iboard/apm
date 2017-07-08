defmodule ApmUserTest do
  use ExUnit.Case
  doctest ApmUser

  test "Default role is 'guest'" do
    assert %ApmUser.Role{}.key == :guest
    assert %ApmUser.Role{}.name == "Guest"
  end
end
