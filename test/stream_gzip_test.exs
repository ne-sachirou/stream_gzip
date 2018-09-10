defmodule StreamGzipTest do
  use ExUnit.Case, async: true

  doctest StreamGzip

  # To generate test fixtures.
  #
  # docker run -v $(pwd)/test/fixture:/var/www --rm ubuntu sh -c 'cd /var/www/ && gzip -kf sample.txt'
  # diff <(gunzip -c test/fixture/sample.txt.gz) test/fixture/sample.txt
  #
  # "test/fixture/sample.txt" |>
  # File.stream!() |>
  # StreamGzip.gzip() |>
  # Stream.into(File.stream!("test/fixture/sample.txt.gz")) |>
  # Stream.run()
  describe "gunzip/1" do
    test "inflate" do
      expected =
        "test/fixture/sample.txt"
        |> File.stream!()
        |> StreamHash.hash(:sha256)
        |> Enum.into("")
        |> Base.encode16()

      actual =
        "test/fixture/sample.txt.gz"
        |> File.stream!([:binary], 1024)
        |> StreamGzip.gunzip()
        |> StreamHash.hash(:sha256)
        |> Enum.into("")
        |> Base.encode16()

      assert expected == actual
    end

    test "Long chunked output" do
      compressed =
        [:crypto.strong_rand_bytes(100_000)] |> StreamGzip.gzip(level: :none) |> Enum.into("")

      assert [compressed] |> StreamGzip.gunzip() |> Enum.all?(&is_binary/1)
    end

    test "Raise the correct error" do
      assert_raise RuntimeError, "Good", fn ->
        "test/fixture/sample.txt.gz"
        |> File.stream!([:binary], 1024)
        |> StreamGzip.gunzip()
        |> Stream.map(fn _ -> raise "Good" end)
        |> Stream.run()
      end
    end
  end

  describe "gzip/1" do
    # test "deflate" do
    #   expected =
    #     "test/fixture/sample.txt.gz"
    #     |> File.stream!()
    #     |> StreamHash.hash(:sha256)
    #     |> Enum.into("")
    #     |> Base.encode16

    #   actual =
    #     "test/fixture/sample.txt"
    #     |> File.stream!()
    #     |> StreamGzip.gzip()
    #     |> StreamHash.hash(:sha256)
    #     |> Enum.into("")
    #     |> Base.encode16

    #   assert expected == actual
    # end

    test "deflateInit level option" do
      expected =
        "test/fixture/sample.txt"
        |> File.stream!()
        |> StreamHash.hash(:sha256)
        |> Enum.into("")
        |> Base.encode16()

      actual =
        "test/fixture/sample.txt"
        |> File.stream!()
        |> StreamGzip.gzip(level: :best_speed)
        |> StreamGzip.gunzip()
        |> StreamHash.hash(:sha256)
        |> Enum.into("")
        |> Base.encode16()

      assert expected == actual
    end

    test "Long chunked output",
      do:
        assert(
          [:crypto.strong_rand_bytes(100_000)]
          |> StreamGzip.gzip()
          |> Enum.all?(&is_binary/1)
        )

    test "Raise the correct error" do
      assert_raise RuntimeError, "Good", fn ->
        "test/fixture/sample.txt"
        |> File.stream!()
        |> StreamGzip.gzip()
        |> Stream.map(fn _ -> raise "Good" end)
        |> Stream.run()
      end
    end
  end
end
