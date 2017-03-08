defmodule MyRouter do
  use Plug.Router
  plug Plug.Logger
  plug :match
  plug :dispatch


  get "/hello" do
    IO.puts "hello"
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "helo world")
  end


  match _ do
    conn |> send_resp(404, "oops")
  end
end
