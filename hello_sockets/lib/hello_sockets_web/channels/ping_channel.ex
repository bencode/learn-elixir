defmodule HelloSocketsWeb.PingChannel do
  use Phoenix.Channel

  def join(_topic, _payload, socket) do
    {:ok, socket}
  end

  def handle_in("ping", payload, socket) do
    IO.inspect payload
    {:reply, {:ok, %{ping: "pong"}}, socket}
  end
end
