defmodule ApmIssues.Adapter.File do

  @doc"""
  Stream from given file, filter remarks and push the entire JSON-objects
  to the repository.
  Please read about `keys: :atoms` at https://github.com/devinus/poison#parser
  """
  def read!(filename) do
    File.stream!(filename)
      |> filter_remarks
      |> Poison.Parser.parse!(keys: :atoms)
      |> ApmIssues.Adapter.push
  end

  defp filter_remarks lines do
    lines
      |> Stream.map( fn(line) ->
           case Regex.match?(~r/\A\s*#.*\Z/, line) do
             true -> ""
             _ -> line
           end
         end)
      |> Enum.join("\n")
  end
end
