defmodule UsersRouter do
  use Plug.Router

  plug :match


  get "/users" do
    send_resp conn, 200, "Hello Users"
  end
end
