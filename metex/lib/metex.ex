defmodule Metex do
  def temperatures_of(cities) do
    coordinator_pid = spawn(Metex.Coordinator, :loop, [[], Enum.count(cities)])

    cities |> Enum.each(fn city ->
      worker_id = spawn(Metex.Worker, :loop, [])
      send(worker_id, {coordinator_pid, city})
    end)
  end
end
