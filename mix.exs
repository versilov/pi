defmodule PI.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_pi,
      version: "1.0.3",
      elixir: "~> 1.6",
      description: description(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      package: package(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      applications: [:logger]
    ]
  end

  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :dev, runtime: false}]
  end

  defp description do
    """
    Pretty Inspect pi() function for those, who love puts debugging.
    """
  end

  defp package do
    [
      name: :ex_pi,
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Stas Versilov"],
      licenses: ["MIT License"],
      links: %{
        "GitHub" => "https://github.com/versilov/pi"
      }
    ]
  end

  defp elixirc_paths(_), do: ["lib"]
end
