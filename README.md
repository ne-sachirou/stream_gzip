StreamGzip
==
Gzip or gunzip a stream.

[![Hex.pm](https://img.shields.io/hexpm/v/stream_gzip.svg)](https://hex.pm/packages/stream_gzip)
[![Build Status](https://travis-ci.org/ne-sachirou/stream_gzip.svg?branch=master)](https://travis-ci.org/ne-sachirou/stream_gzip)
[![Coverage Status](https://coveralls.io/repos/github/ne-sachirou/stream_gzip/badge.svg)](https://coveralls.io/github/ne-sachirou/stream_gzip)

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

Installation
--
Add `stream_gzip` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:stream_gzip, "~> 0.3"}]
end
```
