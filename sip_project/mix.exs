defmodule SipProject.MixProject do
  use Mix.Project

  def project do
    [
      app: :sip_project,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {SipProject, []},
      extra_applications: [:logger],
      applications: [:sippet]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
        {:dialyxir, "~> 1.0", only: [:dev]},
        {:ex_doc, "~> 0.24", only: :dev, runtime: false},
        {:sippet, "~> 1.0.9"},
        {:sippet_uri, "~> 0.1"},
        {:yaml_elixir, "~> 2.8.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
