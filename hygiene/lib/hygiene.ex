defmodule Hygiene do
  defmacro no_interference do
    quote do
      a = 1
      var!(b) = 1
    end
  end
end


defmodule HygieneTest do
  def go do
    require Hygiene
    a = 13
    Hygiene.no_interference
    [a, b]
  end
end


defmodule Sample do
  defmacro initialize_to_char_count(variables) do
    IO.inspect variables
    Enum.map variables, fn(name) ->
      var = Macro.var(name, nil)
      length = name |> Atom.to_string |> String.length
      quote do
        unquote(var) = unquote(length)
      end
    end
  end

  def run do
    initialize_to_char_count [:red, :green, :yellow]
  end
end

