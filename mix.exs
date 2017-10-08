defmodule StreamGzip.Mixfile do
  use Mix.Project

  def project do
    [
      app: :stream_gzip,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: "Gzip or gunzip a stream.",
      package: package(),
      aliases: aliases(),
      deps: deps(),
      # Docs
      name: "StreamGzip",
      source_url: "https://github.com/ne-sachirou/stream_gzip",
      homepage_url: "https://github.com/ne-sachirou/stream_gzip",
      docs: [
        main: "StreamGzip",
        extras: ["README.md"],
      ],
    ]
  end

  def application do
    [extra_applications: []]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.17", only: :dev, runtime: false},
      {:inner_cotton, github: "ne-sachirou/inner_cotton", only: [:dev, :test]},
      {:stream_hash, "~> 0.1", only: :test},
    ]
  end

  defp aliases do
    [
      "lint": ["cotton.lint"],
    ]
  end

  defp package do
    [
      licenses: ["GPL-3.0"],
      name: :stream_gzip,
      maintainers: ["ne_Sachirou <utakata.c4se@gmail.com>"],
      links: %{
        "GitHub": "https://github.com/ne-sachirou/stream_gzip",
      },
      files: ["LICENSE", "README.md", "mix.exs", "lib"]
    ]
  end
end
