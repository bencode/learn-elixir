defmodule Chucky do
  use Application
  require Logger


  def start(type, _args) do
    import Supervisor.Spec
    children = [
      worker(Chunck.Server, [])
    ]

    case type do
      :normal ->
        Logger.info "Application is started on #{node}"

      {:takeover, old_node} ->
        Logger.info "#{node} is takeover #{old_node}"

      {:failover, old_node}
        Logger.info "#{old_node} is failover to #{node}"
    end

    opts = [strategy: :one_for_onoe, name: {:global, Chucky.Supervisor}]
    Supervisor.start_link(children, opts)
  end


  def fact do
    Chucky.Server.fact
  end
end