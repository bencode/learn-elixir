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

  defmacro __using__(_opts) do
    import A.B.C
    quote do
      import Complex
      alias A.B.C, as: ABC
      def say do
        hi() + 1
      end
    end
  end
end


defmodule UseComplex do
  use Complex

  def go do
    IO.puts add(1, 2)
    IO.puts mul(3, 4)
    IO.puts say()
    IO.puts ABC.hi()
    #IO.puts hi()    # (CompileError) c.exs:38: undefined function hi/0
  end
end


UseComplex.go
