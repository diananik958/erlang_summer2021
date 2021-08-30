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
      Sippet.child_spec([name: :project]),
      Sippet.Transports.UDP.child_spec([name: :project])
    ]

    opts = [strategy: :one_for_one, name: Sip_project.Supervisor]
    sv = Supervisor.start_link(children, opts)
    Logger.info("children output")
    Logger.info(Kernel.inspect(children))
    Logger.info("opts output")
    Logger.info(opts)
    Sippet.register_core(:project, MyCore)
    Sippet.register_transport(:project, :udp, true)
    Logger.info("sv output")
    Logger.info(Kernel.inspect(sv))
    Sippet.send(:project, SenReq.send_reg_request())
    #Sippet.send(:project, SenReq.send_inv_request())
    sv

  end
end
