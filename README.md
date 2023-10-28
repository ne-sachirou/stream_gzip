# StreamGzip

[![Actions Status](https://github.com/ne-sachirou/stream_gzip/workflows/test/badge.svg)](https://github.com/ne-sachirou/stream_gzip/actions)
[![Coverage Status](https://coveralls.io/repos/github/ne-sachirou/stream_gzip/badge.svg)](https://coveralls.io/github/ne-sachirou/stream_gzip)
[![Hex.pm](https://img.shields.io/hexpm/v/stream_gzip.svg)](https://hex.pm/packages/stream_gzip)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/stream_gzip/)
[![Total Download](https://img.shields.io/hexpm/dt/stream_gzip.svg)](https://hex.pm/packages/stream_gzip)
[![License](https://img.shields.io/hexpm/l/stream_gzip.svg)](https://github.com/ne-sachirou/stream_gzip/blob/master/LICENSE)
[![Last Updated](https://img.shields.io/github/last-commit/ne-sachirou/stream_gzip.svg)](https://github.com/ne-sachirou/stream_gzip/commits/master)

Gzip or gunzip a stream.

## Installation

Add `:stream_gzip` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:stream_gzip, "~> 0.4"}
  ]
end
```

## Usage

Gunzip:

```elixir
"x.gz"
|> File.stream!([:binary], 1024)
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

## Copyright and License

Copyright (c) 2017 ne_Sachirou

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
