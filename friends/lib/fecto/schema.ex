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
    prelude =
      quote do
        @after_compile FEcto.Schema
        Module.register_attribute(__MODULE__, :struct_fields, accumulate: true)

        source = unquote(source)
        meta = %{source: source}
        Module.put_attribute(__MODULE__, :struct_fields, {:__meta__, meta})

        try do
          import FEcto.Schema
          unquote(block)
        after
          :ok
        end
      end

    postlude =
      quote unquote: false do
        defstruct @struct_fields

        def __schema__(:source), do: unquote(source)
      end

    quote do
      unquote(prelude)
      unquote(postlude)
    end
  end

  def __after_compile__(%{module: module} = env, _) do
    IO.inspect {"after_compile", module}
  end

  defmacro field(name, type) do
    quote do
      FEcto.Schema.__field__(__MODULE__, unquote(name), unquote(type))
    end
  end

  def __field__(mod, name, type) do
    define_field(mod, name, type)
  end

  defp define_field(mod, name, type) do
    Module.put_attribute(mod, :struct_fields, {name, type})
  end
end
