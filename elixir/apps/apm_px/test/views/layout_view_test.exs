defmodule ApmPx.LayoutViewTest do
  use ApmPx.ConnCase, async: true

  # Prevent warning about @endpoint isn't used
  require Logger
  Logger.debug "Using #{inspect @endpoint}"
end
