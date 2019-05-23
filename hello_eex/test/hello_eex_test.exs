defmodule HelloEexTest do
  use ExUnit.Case
  doctest HelloEex

  test "greets the world" do
    assert HelloEex.hello() == :world
  end
end
