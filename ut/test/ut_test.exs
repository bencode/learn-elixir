defmodule UtTest do
  use ExUnit.Case
  doctest Ut

  require Logger
  import ExUnit.CaptureIO
  import ExUnit.CaptureLog

  test "use CaptureIO" do
    assert capture_io(fn ->
      IO.puts "a"
    end) == "a\n"
  end

  test "use CaptureLog" do
    assert capture_log(fn ->
      Logger.error "log msg"
    end) =~ "log msg"
  end


end
