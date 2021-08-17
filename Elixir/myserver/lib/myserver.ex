defmodule MYSERVER do
  
  @moduledoc """
  Documentation for `MYSERVER`.
  """
  import SweetXml
  use Application
  require Logger

  def insert_xml do
    {:ok, doc} = File.read(Path.expand("lib/data.xml"))
    host = doc |> xpath(~x"//db/host/text()"l)
    user = doc |> xpath(~x"//db/user/text()"l)
    password = doc |> xpath(~x"//db/password/text()"l)
    database = doc |> xpath(~x"//db/database/text()"l)
    data = host ++ user ++ password ++ database
    data
    #doc |> xpath(~x"//header", message: ~x"./p/text()", a_in_li: ~x".//li/a/text()"l)
    #doc
  end

  def start(_type, _args) do
    #:testserver.main
    children = [
      {Plug.Cowboy, scheme: :http, plug: Router, options: [port: 8080]}
    ]
    opts = [strategy: :one_for_one, name: Example.Supervisor]

    Logger.info("Starting application...")

    Supervisor.start_link(children, opts)
  end

end
