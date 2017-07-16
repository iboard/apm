defmodule ApmPx.PageViewTest do
  use ExUnit.Case
  use ApmPx.ConnCase, async: true

  # Prevent warning about @endpoint isn't used
  require Logger
  Logger.debug "Using endpoint #{@endpoint}"
end
