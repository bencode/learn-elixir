defmodule NoMagicTest do
  use ExUnit.Case
  doctest NoMagic

  test "greets the world" do
    assert NoMagic.hello() == :world
  end
end
