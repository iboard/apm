defmodule ApmIssues.Repository do
  require Logger

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
    case GenServer.start_link(__MODULE__, %{ issues: [] , refs: []}, name: __MODULE__) do
      {:ok, pid} -> seed(pid)
      {:error, {:already_started, pid}} -> {:ok, pid}
    end
  end

  # In current state of development, Issues are always loaded from fixture
  # files. In further versions this function will go away and issues will be
  # loaded lazily
  defp seed(pid) do
    ApmIssues.Repository.drop!
    ApmIssues.Repository.Seed.load()
    {:ok, pid} 
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
  def push!(issue_pid) do
    :ok = push(issue_pid)
    issue_pid
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
  Fetch Issues with parent_id = nil
  ## Example:
      iex> roots = ApmIssues.Repository.root_issues()
      iex> Enum.count(roots)
      2
  """
  def root_issues() do
    GenServer.call(__MODULE__, :root_issues)
  end


  @doc"""
  Find an issue by it's id
  returns the pid of the issue if found

  ## Example:
      
      iex> ApmIssues.Repository.drop!
      iex> ApmIssues.Issue.new(1,"Some Title") |> ApmIssues.Repository.push()
      iex> ApmIssues.Repository.find_by_id(1) |> ApmIssues.Issue.state
      %ApmIssues.Issue{ id: 1, subject: "Some Title", options: %{}, children: [] }
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
  def handle_call(:root_issues, _from, state) do
    {:reply, state.issues |> filter_roots, state}
  end

  @doc false
  def handle_call({:find_by_id, id}, _from, state) do
    issue = find_issue(state,id)
    {:reply, issue, state}
  end

  @doc false
  def handle_cast({:push, issue}, %{issues: issues, refs: refs}) do
    id = Issue.state(issue).id
    if Enum.member?(issues, {issue, id}) do 
      ignore_existing_issue(issues, issue, refs)
    else 
      register_issue(issues, issue, id, refs)
    end
  end

  @doc false
  def handle_cast(:drop, %{issues: _issues, refs: refs}) do
    drop_all_issues_by_refs(refs)
    {:noreply, %{ issues: [], refs: [] }}
  end

  @doc false
  def handle_info({:DOWN, ref, :process, pid, reason}, %{ issues: issues, refs: refs}) do
    Logger.info "REMOVE ISSUE FROM REPO: #{inspect [ref,pid]}, REASON: #{inspect reason}"
    {:noreply, %{issues: remove_issue(issues,pid), refs: remove_ref(refs,ref)}}
  end

  # ------------------------------------------------------------
  # Private helpers
  #-------------------------------------------------------------

  defp find_issue(state, id) do
    result = state.issues |> Enum.filter(fn({_pid,fid}) -> fid == id end)
    case result do
      [first|_] -> first
      _ -> :not_found
    end
  end

  defp filter_roots issues do
    issues
    |> Enum.filter( fn(issue) ->
      ApmIssues.Issue.state(issue).parent_id == nil
    end)
  end

  defp ignore_existing_issue(issues, issue, refs) do
    Logger.info "IGNORE: ISSUE ALREADY IN REPO: #{inspect issue}"
    {:noreply, %{ issues: issues, refs: refs }}
  end

  defp register_issue(issues, issue, id, refs) do
    ref = Process.monitor(issue)
    new_issues = [ {issue, id} | issues ]
    new_refs   = [ {ref,issue} | refs ]
    {:noreply, %{ issues: new_issues, refs: new_refs }}
  end

  @doc false
  defp drop_all_issues_by_refs(refs) do
    refs
    |> Enum.each( fn {ref,id} ->
        Logger.info "DROP ISSUE #{inspect(id)} WITH REF: #{inspect ref}"
        Issue.drop(id)
       end)
  end

  @doc false
  defp remove_issue(issues, pid) do
    Enum.filter(issues, fn({issue_pid, _issue_id}) ->
      issue_pid != pid 
    end)
  end

  @doc false
  defp remove_ref(refs, ref) do
    Enum.filter(refs, fn({r,_issue}) ->
      r != ref 
    end)
  end
end

