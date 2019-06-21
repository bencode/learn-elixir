defmodule ReadingPlugTest do
  use ExUnit.Case
  doctest ReadingPlug

  test "greets the world" do
    assert ReadingPlug.hello() == :world
  end
end
