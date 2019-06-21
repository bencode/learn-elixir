defmodule MyPlug do
  import Plug.Conn

  def init(options) do
    options
  end

  def call(conn, _opts) do
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, "Test")
  end
end
