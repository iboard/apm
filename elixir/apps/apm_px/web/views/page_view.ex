defmodule ApmPx.PageView do
  alias ApmPx.SessionView
  use ApmPx.Web, :view


  def markdown(filename) do
    filename 
      |> File.read!
      |> Earmark.as_html!
      |> raw
  end
end
