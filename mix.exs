defmodule Checkout.MixProject do
  use Mix.Project

  def project do
    [
      app: :two_phase_commit_example,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:two_phase_commit, git: "git@github.com:qixxit/two_phase_commit.git"},
      {:uuid, "~> 1.1"}
    ]
  end
end
