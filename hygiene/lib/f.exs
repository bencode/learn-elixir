defmodule Mex do
  def expand_all(n, env) do
    Macro.prewalk(n, &Macro.expand(&1, env))
  end

  defmacro mex(do: block) do
    block
    |> expand_all(__CALLER__)
    |> IO.inspect
  end
end


defmodule Hygiene do
  defmacro no_interference do
    quote do
      a = 1
    end
  end
end


defmodule Main do
  require Mex
  require Hygiene

  def run do
    Mex.mex do
      a = 13
      Hygiene.no_interference
      a
    end
  end
end


Main.run
