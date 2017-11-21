defmodule GenstateExp.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(GenstateExp.Producer, [0]),
      worker(GenstateExp.ProducerConsumer, []),
      worker(GenstateExp.Consumer, [], id: 1),
      worker(GenstateExp.Consumer, [], id: 2)
    ]

    opts = [strategy: :one_for_one, name: GenstateExp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
