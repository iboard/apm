defmodule ApmIssues.Issue do
  @moduledoc """
  Define `%{ApmIssues.Issue}` and functions to modify it.

  In function new, an Agent is started to hold the state of
  an Issue. All other functions take the pid, returned by `new`,
  as their first argument.
  """

  @doc "The state of an issue is kept in this structure"
  defstruct id: nil, subject: "", options: %{}, children: [], parent_id: nil

  @doc """
  * `id` - Unique ID of the issue (mandatory when saving)
  * `subject` - Any string (mandatory but can be an empty string)
  * `options` - optional and not specified yet

  ## Example:

      iex> pid = ApmIssues.Issue.new( 1, "My Title" )
      iex> ApmIssues.Issue.state(pid)
      %ApmIssues.Issue{options: %{}, id: 1, subject: "My Title", parent_id: nil}

      iex> pid = ApmIssues.Issue.new( 1, "One", %{state: :new} )
      iex> ApmIssues.Issue.state(pid)
      %ApmIssues.Issue{id: 1, options: %{state: :new}, subject: "One", parent_id: nil}

  """
  def new( id, subject, opts \\ %{} ) do
    {:ok, pid} = Agent.start_link(fn -> 
      %ApmIssues.Issue{ id: id, subject: subject, options: opts }
    end)
    ApmIssues.Repository.push!(pid)
  end

  @doc"""
  Stops the Agent for the given pid.
  Note: This will be triggered by the Repository and it will be removed from it.
  """
  def drop(pid) do
    Agent.stop(pid)
  end

  @doc """
  Issues may be initialized by simple structs when read from file-adapter

  ## Example

      iex> pid = ApmIssues.Issue.new( %{id: 1, subject: "Item One"})
      iex> ApmIssues.Issue.state(pid)
      %ApmIssues.Issue{children: [], id: 1, options: %{}, subject: "Item One", parent_id: nil }
  """
  def new(pid) when is_pid(pid), do: pid
  def new(_struct =  %{id: id, subject: subject, options: options, parent_id: _parent_id, children: children}) do
    new(id,subject,options) |> add_children(children)
  end
  def new(_struct =  %{id: id, subject: subject, parent_id: _parent_id, options: options}) do
    new(id,subject,options)
  end
  def new(_struct =  %{id: id, subject: subject, children: children} ) do
    new(id,subject) |> add_children(children)
  end
  def new(_struct =  %{id: id, subject: subject} ) do
    new(id,subject)
  end

  defp add_children(pid, children) do
    Enum.each(children, fn(child) -> add_child(pid,new(child)) end)
    pid
  end

  @doc """
  Return the state of an Issue with a given tuple of `{pid, id}` 
  as returned from `ApmIssues.Repository` and `ApmIssues.Issue.children`
  """
  def state({pid, _id}), do: state(pid)

  @doc """
  Returns the current state of an issue, identified by it's `pid`
  You can use `state({ pid, id})` as an alternative.

  ## Example:

      iex> subject = ApmIssues.Issue.new( "ID", "TITLE", %{state: "NEW"} )
      iex> ApmIssues.Issue.state(subject)
      %ApmIssues.Issue{ id: "ID", subject: "TITLE", options: %{state: "NEW"}, parent_id: nil}

  """
  def state(pid) do
    Agent.get(pid, fn issue -> issue end)
  end

  @doc """
  Return a list of tuples { pid, id } for all children

  ## Example

      iex> father_pid = ApmIssues.Issue.new( "father", "Frank" )
      iex> daughter_pid = ApmIssues.Issue.new( "daughter", "Moon Unit" )
      iex> ApmIssues.Issue.add_child(father_pid, daughter_pid)
      iex> { pid, id } = ApmIssues.Issue.children(father_pid) |> hd
      iex> { is_pid(pid), id }
      { true, "daughter" }
  """
  def children( pid ) do
    ApmIssues.Issue.state(pid).children
  end

  @doc """
  Add a child to the list of children

  ## Example:

      iex> father_pid = ApmIssues.Issue.new( "father", "Frank" )
      iex> son_pid    = ApmIssues.Issue.new( "son", "Dweezil" )
      iex> ApmIssues.Issue.add_child(father_pid, son_pid)
      iex> { child_pid, _child_id }  = ApmIssues.Issue.children(father_pid) |> hd 
      iex> ApmIssues.Issue.state(child_pid).subject
      "Dweezil"

  """
  def add_child( parent_pid, child_pid ) do
    Agent.update(parent_pid, fn issue ->
      update_parent_id_on_child(child_pid, issue.id)
      add_child_to_issue(issue,child_pid)
    end)
    parent_pid
  end

  defp add_child_to_issue(issue,child_pid) do
    Map.merge issue, %{ 
      children: [ { child_pid, ApmIssues.Issue.state(child_pid).id } | issue.children ]
    }
  end

  defp update_parent_id_on_child(child_pid, parent_id) do
    Agent.update(child_pid, fn child ->
      Map.merge(child, %{parent_id: parent_id})
    end)
  end
end
