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
      @after_compile FEcto.Schema
    end
  end

  def __after_compile__(%{module: module} = env, _) do
    IO.inspect {"after_compile", module}
  end
end
