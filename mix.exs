defmodule Widgets.MixProject do
  use Mix.Project

  def project do
    [app: :widgets, version: "0.1.0", elixir: "~> 1.17", deps: deps()]
  end

  def application, do: [extra_applications: [:logger]]

  defp deps, do: [{:ecto_sql, "~> 3.12"}, {:jason, "~> 1.4"}]
end
