defmodule HiTaskTest do
  use ExUnit.Case
  doctest HiTask
  require Logger

  test "general use" do
    dur =
      cost("task 1", fn ->
        task = Task.async(fn -> Process.sleep(100) end)
        Task.await(task)
      end)

    assert dur > 100 * 1000
  end

  defp cost(name, fun) do
    start = :os.system_time(:microsecond)
    fun.()
    finish = :os.system_time(:microsecond)
    dur = finish - start
    Logger.debug("#{name} cost #{dur}us}")
    dur
  end
end
