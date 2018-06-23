defmodule StreamGzip do
  @moduledoc """
  Gzip or gunzip a stream.
  """

  defmacrop iolist_to_iovec(iolist) do
    if function_exported?(:erlang, :iolist_to_iovec, 1) do
      quote do: :erlang.iolist_to_iovec(unquote(iolist))
    else
      quote do: List.flatten(unquote(iolist))
    end
  end

  @doc """
  Gunzip the stream.

      iex> [<<31, 139, 8, 0, 0, 0, 0, 0, 0, 3, 171, 168, 172, 170, 168, 172, 2, 0, 60, 143, 60, 178, 6, 0, 0, 0>>]
      iex> |> StreamGzip.gunzip
      iex> |> Enum.into("")
      "xyzxyz"
  """
  @spec gunzip(Enumerable.t()) :: Enumerable.t()
  def gunzip(enum) do
    Stream.transform(
      enum,
      fn ->
        z = :zlib.open()
        :zlib.inflateInit(z, 16 + 15)
        z
      end,
      fn compressed, z ->
        enum =
          Stream.resource(
            fn -> :zlib.inflateChunk(z, compressed) end,
            fn
              :halt -> {:halt, nil}
              {:more, decompressed} -> {List.wrap(decompressed), :zlib.inflateChunk(z)}
              decompressed -> {List.wrap(decompressed), :halt}
            end,
            & &1
          )

        {enum, z}
      end,
      &:zlib.close/1
    )
  end

  @doc """
  Gzip the stream.

      iex> ["xyzxyz"] |> StreamGzip.gzip |> Enum.into("")
      <<31, 139, 8, 0, 0, 0, 0, 0, 0, 3, 171, 168, 172, 170, 168, 172, 2, 0, 60, 143, 60, 178, 6, 0, 0, 0>>
  """
  @spec gzip(Enumerable.t()) :: Enumerable.t()
  def gzip(enum), do: gzip(enum, level: :default)

  @spec gzip(Enumerable.t(), level: :none | :default | :best_compression | :best_speed | 0..9) ::
          Enumerable.t()
  def gzip(enum, opts) do
    z = :zlib.open()
    :zlib.deflateInit(z, opts[:level] || :default, :deflated, 16 + 15, 8, :default)

    transform_with_final(enum, z, &{iolist_to_iovec(:zlib.deflate(&2, &1)), &2}, fn z ->
      iolist = iolist_to_iovec(:zlib.deflate(z, "", :finish))
      :zlib.deflateEnd(z)
      :zlib.close(z)
      {iolist, z}
    end)
  end

  @spec transform_with_final(Enumerable.t(), acc, fun, final_fun) :: Enumerable.t()
        when fun: (Stream.element(), acc -> {Enumerable.t(), acc} | {:halt, acc}),
             final_fun: (acc -> {Enumerable.t(), acc} | {:halt, acc}),
             acc: any
  defp transform_with_final(enum, acc, reducer, final_fun) do
    sentinel = make_ref()

    enum
    |> Stream.concat([sentinel])
    |> Stream.transform(acc, fn
      ^sentinel, acc -> final_fun.(acc)
      element, acc -> reducer.(element, acc)
    end)
  end
end
