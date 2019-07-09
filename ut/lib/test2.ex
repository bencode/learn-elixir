defmodule Test2 do
  def test do
    a = Task.async fn -> load_a() end
    b = Task.async fn -> load_b() end
    c = Task.async fn -> load_c() end
    d = Task.async fn -> load_d() end

    data = %{
      a: wait_timeout(:a, a),
      b: wait_timeout(:b, b),
      c: wait_timeout(:c, c),
      d: wait_timeout(:d, d),
    }

    IO.inspect data
  end

  defp wait_timeout(name, task, timeout \\ 2000) do
    IO.inspect "#{name} start"
    ret =
      case Task.yield(task, timeout) || Task.shutdown(task) do
        {:ok, result} -> result
        nil -> nil
    end
    IO.inspect "#{name} end"
    ret
  end


  defp load_a do
    Process.sleep(1000)
    "a"
  end

  defp load_b do
    Process.sleep(2000)
    "b"
  end

  defp load_c do
    Process.sleep(3000)
    "c"
  end

  defp load_d do
    Process.sleep(8000)
    "d"
  end
end


Test2.test
