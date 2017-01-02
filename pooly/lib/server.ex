defmodule Pooly.Server do
  use GenServer
  import Supervisor.Spec


  defmodule State do
    defstruct sup: nil, size: nil, mfa: nil, monitors: nil, workers: nil
  end


  def start_link(sup, pool_config) do
    GenServer.start_link(__MODULE__, [sup, pool_config], name: __MODULE__)
  end


  def checkout do
    GenServer.call(__MODULE__, :checkout)
  end


  def checkin(worker_pid) do
    GenServer.cast(__MODULE__, {:checkin, worker_pid})
  end


  def status() do
    GenServer.call(__MODULE__, :status)
  end


  def init([sup, pool_config]) when is_pid(sup) do
    monitors = :ets.new(:monitors, [:private])
    init(pool_config, %State{sup: sup, monitors: monitors})
  end

  ## 这段递归程序用于执行一个判断和更新到state的操作
  ## 如果我来实现的话，很可能使用迭代
  ## 不过迭代应该也不会复杂
  def init([{:mfa, mfa} | rest], state) do
    init(rest, %State{state | mfa: mfa})
  end

  def init([{:size, size} | rest], state) do
    init(rest, %State{state | size: size})
  end

  def init([_ | rest], state) do
    init(rest, state)
  end

  def init([], state) do
    send(self, :start_worker_supervisor)
    {:ok, state}
  end


  def handle_call(:checkout, {from_pid, _ref}, %{workers: workers, monitors: monitors} = state) do
    case workers do
      [worker | rest] ->
        ref = Process.monitor(from_pid)
        true = :ets.insert(monitors, {worker, ref})
        {:reply, worker, %{state | workers: rest}}
      [] ->
        {:reply, :noproc, state}
    end
  end


  def handle_call(:status, _from, %{monitors: monitors, workers: workers} = state) do
    {:reply, {length(workers), :ets.info(monitors, :size)}, state}
  end


  def handle_cast({:checkin, worker}, %{workers: workers, monitors: monitors} = state) do
    case :ets.lookup(monitors, worker) do
      [{pid, ref}] ->
        true = Process.demonitor(ref)
        true = :ets.delete(monitors, pid)
        {:noreply, %{state | workers: [pid | workers]}}
      [] ->
        {:noreply, state}
    end
  end


  def handle_info(:start_worker_supervisor,
      state = %{sup: sup, size: size, mfa: mfa}) do
    {:ok, worker_sup} = Supervisor.start_child(sup, supervisor_spec(mfa))
    workers = prepopulate(size, worker_sup)
    {:noreply, %{state | sup: worker_sup, workers: workers}}
  end


  defp supervisor_spec(mfa) do
    opts = [restart: :temporary]
    supervisor(Pooly.WorkerSupervisor, [mfa], opts)
  end


  ## 这个又是一个递归迭代
  defp prepopulate(size, sup) do
    prepopulate(size, sup, [])
  end

  ## 终止条件
  defp prepopulate(size, _sup, workers) when size < 1 do
    workers
  end

  ## 入口
  defp prepopulate(size, sup, workers) do
    prepopulate(size - 1, sup, [new_worker(sup) | workers])
  end


  defp new_worker(sup) do
    {:ok, worker} = Supervisor.start_child(sup, [[]])
    worker
  end
end
