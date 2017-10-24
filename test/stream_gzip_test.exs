defmodule StreamGzipTest do
  use ExUnit.Case, async: true

  doctest StreamGzip

  describe "gunzip/1" do
    test "deflate" do
      expected = "test/fixture/sample.txt"
        |> File.stream!
        |> StreamHash.hash(:sha256)
        |> Enum.to_list
      actual = "test/fixture/sample.txt.gz"
        |> File.stream!([:binary], 1024)
        |> StreamGzip.gunzip
        |> StreamHash.hash(:sha256)
        |> Enum.to_list
      assert expected == actual
    end
  end

  describe "gzip/1" do
    test "inflate" do
      expected = "test/fixture/sample.txt.gz"
        |> File.stream!
        |> StreamHash.hash(:sha256)
        |> Enum.to_list
      actual = "test/fixture/sample.txt"
        |> File.stream!
        |> StreamGzip.gzip
        |> StreamHash.hash(:sha256)
        |> Enum.to_list
      assert expected == actual
    end

    test "deflateInit level option" do
      expected = "test/fixture/sample.txt"
        |> File.stream!
        |> StreamGzip.gzip(level: :best_speed)
        |> StreamGzip.gunzip
        |> StreamHash.hash(:sha256)
        |> Enum.to_list
      actual = "test/fixture/sample.txt"
        |> File.stream!
        |> StreamHash.hash(:sha256)
        |> Enum.to_list
      assert expected == actual
    end
  end
end
