defmodule Syntax do
  def hello do
    hello = fn ->
      "Hello World"
    end
    hello.()
  end


  def a do
    add = fn(a, b) -> a + b end
    add4 = fn(a) -> add.(4, a) end
    add4.(5)
  end

  def b do
    add = &(&1 + &2)
    add4 = &(add.(4, &1))
    add4.(5)
  end

  def c do
    f = &add(&1, &2)
    f.(1, 2)

    k = &hello/0
    k.()

    # g = &add(4, 5)
    # g.()
  end

  def d do
    add = fn(x, y) ->
      x + y
    end

    # add2 = fn(x, y) do
    #   x + y
    # end
  end

  def add(a, b) do
    a + b
  end

  defmacro myfn(f, a, b) do
    IO.inspect(f)
    IO.inspect(a)
    IO.inspect(b)
  end
end
