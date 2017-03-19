defmodule MyUpload do
  use Plug.Router

  plug Plug.Logger
  if Mix.env == :dev do
    use Plug.Debugger
  end

  plug :match
  plug Plug.Parsers, parsers: [:urlencoded, :multipart, :json],
                     pass: ["*/*"],
                     json_decoder: Poison
  plug :dispatch

  post "/upload" do
    %{filename: filename, path: path} = conn.body_params["file"]
    if File.exists? path do
      Logger.debug("compress video: #{path}")
      compress_video(path)
      conn |> send_resp(200, "success!")
    else
      conn |> send_resp(200, "error!")
    end
  end


  defp compress_video(path) do
  end
end
