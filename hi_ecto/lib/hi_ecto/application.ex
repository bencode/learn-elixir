defmodule HiEcto.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      HiEcto.Repo
    ]

    opts = [strategy: :one_for_one, name: HiEcto.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
