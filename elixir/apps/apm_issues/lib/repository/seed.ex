defmodule ApmIssues.Repository.Seed do
  @moduledoc"""
  For now it is enough to load a couple of Issues from a fixture file.
  In further development, this module will be responsible to initialize
  Lazy loading when the application is started. And the structure of
  JSON-Files will be changed from a single file into a directory-structure.
  """

  @fixture_file Path.expand("../../../../data/fixtures/issues.json", __DIR__)

  def load do
    ApmIssues.Adapter.File.read!(@fixture_file)
  end

end

