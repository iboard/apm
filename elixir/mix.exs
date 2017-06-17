defmodule Apm.Mixfile do
  @moduledoc false

  use Mix.Project

  def project do
    [
      apps_path: "apps",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      version: "0.0.0",

      # Docs
      name: "The Agile Project Manager",
      source_url: "https://github.com/iboard/apm",
      #homepage_url: "http://not set up yet"
      docs:  docs()  
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.14", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      main: "APM", # The main page in the docs
      logo: "apps/apm_px/web/static/assets/images/apm-logo-top.png",
      extras: ["README.md"]
    ]
  end
end
