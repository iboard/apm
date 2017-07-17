defmodule ApmIssues do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(ApmIssues.Repository, []),
    ]

    opts = [strategy: :one_for_one, name: ApmIssues.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
