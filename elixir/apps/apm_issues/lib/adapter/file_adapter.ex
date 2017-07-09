defmodule ApmIssues.Adapter.File do

  def read!(filename) do
    File.stream!(filename)
      |> filter_remarks
      |> Poison.Parser.parse!(keys: :atoms!)
      |> ApmIssues.Adapter.push
  end

  defp filter_remarks lines do
    lines
      |> Enum.map( fn(line) ->
           case Regex.match?(~r/\A#.*\Z/, line) do
             true -> ""
             _ -> line
           end
         end)
      |> Enum.join("\n")
  end
end
