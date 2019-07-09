defmodule Test do
  def load_all do
    a = Task.async fn -> load_a() end
    b = Task.async fn -> load_b() end
    c = Task.async fn -> load_c() end
    d = Task.async fn -> load_d() end

    tasks = [a, b, c, d]
    data =
      tasks
      |> Task.yield_many(3000)
      |> Enum.map(fn {task, res} ->
        case res do
          {:ok, data} -> data
          _ ->
            Task.shutdown(task, :brutal_kill)
            nil
        end
      end)

    ret = 
      [:a, :b, :c, :d]
      |> Enum.zip(data)
      |> Map.new

    IO.inspect ret
  end

  def load_a do
    Process.sleep(1000)
    "a"
  end

  def load_b do
    Process.sleep(2000)
    "b"
  end

  def load_c do
    Process.sleep(3000)
    "c"
  end

  def load_d do
    Process.sleep(4000)
    "d"
  end
end


Test.load_all()
