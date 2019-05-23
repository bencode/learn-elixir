defmodule UtTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import ExUnit.CaptureLog

  test "test output_something" do
    assert capture_io(fn ->
      Ut.Capture.output_something()
    end) == "hi elixir\n"
  end

  test "use CaptureLog" do
  end
end
