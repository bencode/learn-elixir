defmodule HelloRouter do
  use Plug.Router

  plug Plug.Logger
  plug :match
  plug :dispatch


  get "/hello" do
    send_resp conn, 200, "Hello World"
  end


  forward "/users", to: UsersRouter


  match _ do
    send_resp conn, 404, "oops"
  end
end
