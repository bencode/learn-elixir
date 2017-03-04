defprotocol Size do
  @doc "Calculates the size (and not the length) of a data structure"
  def size(data)
end


defimpl Size, for: Binary do
  def size(binary), do: byte_size(binary)
end


defimpl Size, for: Map do
  def size(map), do: map_size(map)
end


defimpl Size, for: Tuple do
  def size(tuple), do: tuple_size(tuple)
end


defmodule MySet do
  defstruct map: %{}

  defimpl Size do
    def size(set) do
      map_size(set)
    end
  end
end


defmodule Print do
  @spec print_size(Size.t) :: :ok
  def print_size(data) do
    IO.puts(Size.size(data))
  end
end
