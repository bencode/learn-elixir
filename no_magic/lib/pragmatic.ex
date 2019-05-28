defmodule Pragmatic do
  def supervisor(worker) do
    spawn_link(fn ->
      Process.flag(:trap_exit, true)
      pid = spawn_link(worker)
      receive do
        {:EXIT, ^pid, _} -> supervisor(worker)
      end
    end)
  end

  def run() do
    worker = fn ->
      :timer.sleep(1_000)
      IO.puts "completed at #{:erlang.system_time()}"
    end
    supervisor(worker)
  end
end

