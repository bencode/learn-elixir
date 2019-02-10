defmodule UseLoggerTest do
  use ExUnit.Case
  doctest UseLogger

  test "greets the world" do
    assert UseLogger.hello() == :world
  end
end
