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
    ]

    opts = [strategy: :one_for_one, name: ApmPx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    ApmPx.Endpoint.config_change(changed, removed)
    :ok
  end
end
