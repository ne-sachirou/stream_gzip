[![Actions Status](https://github.com/ne-sachirou/stream_gzip/workflows/test/badge.svg)](https://github.com/ne-sachirou/stream_gzip/actions)
[![Coverage Status](https://coveralls.io/repos/github/ne-sachirou/stream_gzip/badge.svg)](https://coveralls.io/github/ne-sachirou/stream_gzip)
[![Hex.pm](https://img.shields.io/hexpm/v/stream_gzip.svg)](https://hex.pm/packages/stream_gzip)

# StreamGzip

Gzip or gunzip a stream.

Gunzip:

```elixir
"x.gz"
|> File.stream!
|> StreamGzip.gunzip
|> Enum.into("")
```

Gzip:

```elixir
"x"
|> File.stream!
|> StreamGzip.gzip
|> Stream.into(File.stream! "x.gz")
|> Stream.run
```

## Installation

Add `stream_gzip` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:stream_gzip, "~> 0.4"}]
end
```
