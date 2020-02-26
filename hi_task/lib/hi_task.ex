defmodule HiTask do
  @moduledoc """
  use task
  """
  require Logger

  def general_use do
    log_time("task 1", fn ->
      task = Task.async(fn -> Process.sleep(100) end)
      Task.await(task)
    end)
  end

  defp log_time(name, fun) do
    start = :os.system_time(:microsecond)
    fun.()
    finish = :os.system_time(:microsecond)
    dur = finish - start
    Logger.debug("#{name} cost #{dur}us}")
  end
end
