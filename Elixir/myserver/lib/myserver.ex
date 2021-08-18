defmodule MYSERVER do
  
  @moduledoc """
  Documentation for `MYSERVER`.
  """
  import SweetXml
  use Application
  require Logger

  def copy_xml do
    {:ok, doc} = File.read(Path.expand("lib/data.xml"))
      host_name = doc |> xpath(~x"//db/host/text()"l)
      user_name = doc |> xpath(~x"//db/user/text()"l)
      password_for_user = doc |> xpath(~x"//db/password/text()"l)
      database_name = doc |> xpath(~x"//db/database/text()"l)
    data = {host_name, user_name, password_for_user, database_name}
    data
  end  

  def start(_type, _args) do
    #:testserver.main
    data = MYSERVER.copy_xml()
    Logger.info(Kernel.inspect(data))
    {hostname, usname, pass, dbname} = data
    Logger.info(List.to_string(pass))
    Logger.info(List.to_string(dbname))
    children = [
      {Plug.Cowboy, scheme: :http, plug: MYSERVER.Router, options: [port: 8080]},
      {MyXQL, username: List.to_string(usname), password: List.to_string(pass), database: List.to_string(dbname), hostname: List.to_string(hostname), name: :myxql}
    ]

    opts = [strategy: :one_for_one, name: Example.Supervisor]

    Logger.info("Starting application...")

    Supervisor.start_link(children, opts)

  end

end
