defmodule MeckdemoTest do
  use ExUnit.Case

  test "hello" do
    import :meck;

    :meck.new Meckdemo

    expect Meckdemo, :hello, fn(msg) ->
      passthrough([msg])
    end

    Meckdemo.hello("A")
    Meckdemo.hello("B")
    Meckdemo.hello("C")
    Meckdemo.hello("D")

    assert num_calls(Meckdemo, :hello, ["A"]) == 1
    assert num_calls(Meckdemo, :hello, :_) == 4

    IO.inspect history(Meckdemo)

    reset Meckdemo
    assert not called(Meckdemo, :hello, :_)

    IO.puts "after reset"
    IO.inspect history(Meckdemo)

    :meck.unload Meckdemo
  end
end
