defmodule HelloPlug do
  import Plug.Conn


  def init(options) do
    options
  end


  def call(conn, _) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Hello World")
  end
end
