defmodule MyEnum do
  @spec map(f, list_1) :: list_2 when
    f: ((a) -> b)
    list_1: [a],
    list_2: [b],
    a: term,
    b: term
  def map(f, [h | t]) do: [f.(h) | map(f, t)]
  def map(f, []) do: []
end
