defmodule ApmPx do
  @moduledoc """
  The _Phoenix Frontend_ application for the _Agile Project Manager_

  as created by mix phoenix.new
  """
  use Application
  @fixture_file Path.expand("../../../data/fixtures/issues.json", __DIR__)

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(ApmPx.Endpoint, []),
      #worker(ApmIssues.Repository, []),
    ]

    opts = [strategy: :one_for_one, name: ApmPx.Supervisor]
    app = Supervisor.start_link(children, opts)
    ApmIssues.Adapter.File.read!(@fixture_file)
    app
  end

  def config_change(changed, _new, removed) do
    ApmPx.Endpoint.config_change(changed, removed)
    :ok
  end
end
