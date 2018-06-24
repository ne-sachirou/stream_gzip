defmodule StreamGzip.Mixfile do
  use Mix.Project

  @github "https://github.com/ne-sachirou/stream_gzip"

  def project do
    [
      app: :stream_gzip,
      build_embedded: Mix.env() == :prod,
      deps: deps(),
      description: "Gzip or gunzip a stream.",
      elixir: "~> 1.5",
      package: package(),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      version: "0.2.4",

      # Docs
      docs: [
        extras: ["README.md"],
        main: "readme"
      ],
      homepage_url: @github,
      name: "StreamGzip",
      source_url: @github
    ]
  end

  def application, do: [extra_applications: []]

  defp deps do
    [
      {:ex_doc, "~> 0.18", only: :dev, runtime: false},
      {:inner_cotton, github: "ne-sachirou/inner_cotton", only: [:dev, :test]},
      {:stream_hash, "~> 0.1", only: :test}
    ]
  end

  defp package do
    [
      files: ["LICENSE", "README.md", "mix.exs", "lib"],
      licenses: ["GPL-3.0-or-later"],
      links: %{GitHub: @github},
      maintainers: ["ne_Sachirou <utakata.c4se@gmail.com>"],
      name: :stream_gzip
    ]
  end
end
