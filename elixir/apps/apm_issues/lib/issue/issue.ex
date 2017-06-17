defmodule ApmIssues.Issue do
  @moduledoc """
  Define `%{ApmIssues.Issue}` and functions to modify it.
  """

  @doc """
  * `id` - Unique ID of the issue (mandatory when saving)
  * `title` - Any string (mandatory but can be an empty string)
  * `options` - optional and not specified yet

  ## Example:

      iex> ApmIssues.Issue.new( 1, "My Title" )
      %ApmIssues.Issue{options: %{}, id: 1, title: "My Title"}

  """
  defstruct id: nil, title: "", options: %{}

  def new( id, title, opts \\ %{} ) do
    %ApmIssues.Issue{ id: id, title: title, options: opts }
  end



end
