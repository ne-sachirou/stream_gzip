defmodule StreamGzip.Mixfile do
  use Mix.Project

  @source_url "https://github.com/ne-sachirou/stream_gzip"
  @version "0.4.1"

  def project do
    [
      app: :stream_gzip,
      version: @version,
      build_embedded: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [
        flags: [:no_undefined_callbacks],
        remove_defaults: [:unknown]
      ],
      elixir: "~> 1.7",
      package: package(),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.github": :test,
        "coveralls.html": :test
      ],
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],

      # Docs
      name: "StreamGzip",
      docs: docs()
    ]
  end

  def application, do: [extra_applications: []]

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:inner_cotton, github: "ne-sachirou/inner_cotton", only: [:dev, :test]},
      {:stream_hash, "~> 0.1", only: :test}
    ]
  end

  defp package do
    [
      name: :stream_gzip,
      description: "Gzip or gunzip a stream.",
      files: ["LICENSE", "README.md", "mix.exs", "lib"],
      licenses: ["GPL-3.0-or-later"],
      maintainers: ["ne_Sachirou <utakata.c4se@gmail.com>"],
      links: %{GitHub: @source_url},
    ]
  end

  defp docs do
    [
      extras: [
        LICENSE: [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      homepage_url: @source_url,
      api_reference: false,
      formatters: ["html"]
    ]
  end
end
