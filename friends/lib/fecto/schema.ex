defmodule FEcto.Schema do
  defmacro __using__(_) do
    quote do
      import FEcto.Schema, only: [schema: 2]
    end
  end

  defmacro schema(source, [do: block]) do
    schema(source, true, :id, block)
  end

  defp schema(source, meta?, type, block) do
    IO.inspect {block}
    quote do
    end
  end
end
