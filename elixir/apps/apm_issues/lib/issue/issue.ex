defmodule ApmIssues.Issue do
  @moduledoc """
  Define `%{ApmIssues.Issue}` and functions to modify it.

  In function new, an Agent is started to hold the state of
  an Issue. All other functions take the pid, returned by `new`,
  as their first argument.
  """

  defstruct id: nil, title: "", options: %{}, children: []

  @doc """
  * `id` - Unique ID of the issue (mandatory when saving)
  * `title` - Any string (mandatory but can be an empty string)
  * `options` - optional and not specified yet

  ## Example:

      iex> pid = ApmIssues.Issue.new( 1, "My Title" )
      iex> ApmIssues.Issue.state(pid)
      %ApmIssues.Issue{options: %{}, id: 1, title: "My Title"}

      iex> pid = ApmIssues.Issue.new( 1, "One", %{state: :new} )
      iex> ApmIssues.Issue.state(pid)
      %ApmIssues.Issue{id: 1, options: %{state: :new}, title: "One"}


  """
  def new( id, title, opts \\ %{} ) do
    {:ok, pid} = Agent.start_link(fn -> 
      %ApmIssues.Issue{ id: id, title: title, options: opts } 
    end)
    pid
  end

  @doc """
  Get the current state of the issue
  """
  def state(pid) do
    Agent.get(pid, fn issue ->
      issue
    end)
  end

  @doc """
  Return the list of children

  ## Example
      iex> father = ApmIssues.Issue.new( "father", "Frank" )
      iex> ApmIssues.Issue.children(father)
      []
  """
  def children( pid ) do
    ApmIssues.Issue.state(pid).children
  end

  @doc """
  Add a child to the list of children

  ## Example:

      iex> father_pid = ApmIssues.Issue.new( "father", "Frank" )
      iex> son_pid    = ApmIssues.Issue.new( "son", "Dweezil" )
      iex> ApmIssues.Issue.add_child( father_pid, son_pid)  
      iex> child_pid  = ApmIssues.Issue.children(father_pid) |> hd 
      iex> ApmIssues.Issue.state(child_pid).title
      "Dweezil"

  """
  def add_child( parent_pid, child_pid ) do
    Agent.update(parent_pid, fn issue ->
      %ApmIssues.Issue{
        id: issue.id,
        title: issue.title,
        options: issue.options,
        children: [ child_pid | issue.children ]
      }
    end)
    parent_pid
  end

end
