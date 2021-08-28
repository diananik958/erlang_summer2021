defmodule SipProject do
  require Logger
  use Application
  @moduledoc """
  Documentation for `SipProject`.
  """

  @doc """
  Sippet Project for Eltex Summer School

  """

  @impl true
  def start(_start_type, _start_args) do

    # Creates a :project Sippet instance
    #Sippet.start_link(name: :project)

    # The below will create a default UDP transport listening on 0.0.0.0:5060/udp
    #Sippet.Transports.UDP.start_link(name: :project)

    children = [
      FileForUsers,
      UserAgent,
      Sippet.child_spec([name: :project]),
      Sippet.Transports.UDP.child_spec([name: :project])
    ]


    opts = [strategy: :one_for_one, name: Sip_project.Supervisor]
    sv = Supervisor.start_link(children, opts)
    Logger.info("children")
    Logger.info(children)
    Logger.info("opts")
    Logger.info(opts)
    Sippet.register_core(:project, MyCore)
    Logger.info("sv")
    Logger.info(Kernel.inspect(sv))
    Sippet.send(:project, SenReq.send_request())
    sv

  end
end
