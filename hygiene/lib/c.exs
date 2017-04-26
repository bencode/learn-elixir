defmodule A.B.C do
  def hi do
    2
  end
end

defmodule Complex do
  def add(a, b) do
    a + b
  end

  def mul(a, b) do
    a * b
  end

  defmacro load do
    import A.B.C
    quote do
      import Complex
      def say do
        hi()
      end
    end
  end
end



defmodule UseComplex do
  require Complex
  Complex.load

  def go do
    add(1, 2)
  end

  def doit do
  end
end


defmodule Main do
  def run do
    require Complex
    ast = quote do
      Complex.load()
    end
    # IO.inspect Macro.expand(ast, __ENV__)
    Macro.expand(ast, __ENV__)
    |> Macro.to_string
    |> IO.puts
  end
end


Main.run()
