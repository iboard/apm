defmodule ApmIssues.Repository.Seed do

  @fixture_file Path.expand("../../../../data/fixtures/issues.json", __DIR__)

  def load do
    ApmIssues.Adapter.File.read!(@fixture_file)
  end

end

