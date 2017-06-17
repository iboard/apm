defmodule ApmIssues do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Starts a worker by calling: ApmIssues.Worker.start_link(arg1, arg2, arg3)
      # worker(ApmIssues.Worker, [arg1, arg2, arg3]),
    ]

    opts = [strategy: :one_for_one, name: ApmIssues.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
