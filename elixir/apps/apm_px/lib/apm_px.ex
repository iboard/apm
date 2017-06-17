defmodule ApmPx do
  @moduledoc """
  The _Phoenix Frontend_ application for the _Agile Project Manager_

  as created by mix phoenix.new
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(ApmPx.Endpoint, []),
      # Start your own worker by calling: ApmPx.Worker.start_link(arg1, arg2, arg3)
      # worker(ApmPx.Worker, [arg1, arg2, arg3]),
    ]

    opts = [strategy: :one_for_one, name: ApmPx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    ApmPx.Endpoint.config_change(changed, removed)
    :ok
  end
end
