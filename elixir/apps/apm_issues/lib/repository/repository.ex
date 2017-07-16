defmodule ApmIssues.Repository do
  @moduledoc """
  The Issue-repository is a `GenServer` which holds the structure `%{ issues: [] }`
  with the list of known issues in the form of a tuple `{ pid, id }`
  """

  use GenServer
  alias ApmIssues.Issue

  # Public API

  @doc """
  Start repository with an 'empty' state. No need to call this function
  because it will be started as a worker by `ApmIssues` application
  """
  def start_link() do
    {:ok, _pid} = GenServer.start_link(__MODULE__, %{ issues: [] }, name: __MODULE__)
  end


  @doc """
  Return the number of items (%ApmIssues.Issue{}) 
  currently stored in the repository

  ## Example:
      iex> ApmIssues.Repository.drop!
      iex> ApmIssues.Repository.count
      0
  """
  def count do
    GenServer.call(__MODULE__, :count)
  end


  @doc"""
  Push an issue into the repository

  ## Example:
      
      iex> ApmIssues.Repository.drop!
      iex> ApmIssues.Repository.count
      0
      iex> i = ApmIssues.Issue.new(1,"Some Title")
      iex> ApmIssues.Repository.push(i)
      iex> ApmIssues.Repository.count
      1
  """
  def push(issue_pid) do
    GenServer.cast(__MODULE__, {:push, issue_pid})
  end

  @doc"""
  Fetch all issues

  ## Example:
      iex> all = ApmIssues.Repository.all()
      iex> Enum.count(all)
      3
  """
  def all() do
    GenServer.call(__MODULE__, :all)
  end


  @doc"""
  Find an issue by it's id
  returns the pid of the issue if found

  ## Example:
      
      iex> ApmIssues.Repository.drop!
      iex> ApmIssues.Issue.new(1,"Some Title") |> ApmIssues.Repository.push()
      iex> ApmIssues.Repository.find_by_id(1) |> ApmIssues.Issue.state
      %ApmIssues.Issue{ id: 1, title: "Some Title", options: %{}, children: [] }
  """
  def find_by_id(id) do
    GenServer.call(__MODULE__, {:find_by_id, id})
  end

  @doc"""
  Empty/clear the repository
  """
  def drop! do
    GenServer.cast(__MODULE__, :drop)
  end

  # GenServer API

  @doc false
  def handle_call(:count, _from, state) do
    {:reply, state.issues |> Enum.count, state}
  end
  
  @doc false
  def handle_call(:all, _from, state) do
    {:reply, state.issues, state}
  end

  @doc false
  def handle_call({:find_by_id, id}, _from, state) do
    result = state.issues
               |> Enum.filter(fn({_pid,fid}) -> fid == id end)
    found =
      case result do
          [first|_] -> first
          _ -> :not_found
      end
    {:reply, found, state}
  end

  @doc false
  def handle_cast({:push, issue}, state) do
    {:noreply, %{ issues: [ { issue, Issue.state(issue).id } | state.issues ] } }
  end

  @doc false
  def handle_cast(:drop, _state) do
    {:noreply, %{ issues: [] }}
  end

end

