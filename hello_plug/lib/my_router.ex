defmodule MyRouter do
  use Plug.Router

  plug Plug.Logger
  if Mix.env == :dev do
    use Plug.Debugger
  end
  use Plug.ErrorHandler

  plug :match
  plug Plug.Parsers, parsers: [:urlencoded, :json],
                     pass: ["application/x-www-form-urlencoded", "application/json"],
                     json_decoder: Poison
  plug :dispatch


  get "/hello" do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "helo world")
  end


  get "/products/:name" do
    send_resp(conn, 200, "products #{name}")
  end


  get "/my/*glob" do
    send_resp(conn, 200, "router after: #{glob}")
  end


  post "/products" do
    IO.inspect conn.body_params
    conn |> send_resp(200, "success!")
  end

  match _ do
    conn |> send_resp(404, "oops")
  end


  defp handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    conn |> send_resp(conn.status, "Something went wrong")
  end
end
