defmodule MyCore do
  use Sippet.Core
  require Logger


  def receive_request(received_request, server_key) do
    IO.inspect(server_key)
    IO.inspect(received_request)
    Logger.info("received request")
    Logger.info(Kernel.inspect(server_key))
    Logger.info(Kernel.inspect(received_request))

    request = Map.get(received_request, :headers)
    case request[:cseq] do
      {_, :register} ->
        Logger.info("Received REGISTER request")
        outgoing_response = received_request |> Sippet.Message.to_response(200)
        Sippet.send(:project, outgoing_response)

      {_, :invite} ->
        Logger.info("Received INVITE request")
        outgoing_response = received_request |> Sippet.Message.to_response(200)
        Sippet.send(:project, outgoing_response)

      _ ->
        Logger.info("Received UNKNOWN request")

      end

  end


  def receive_response(received_response, client_key) do
    IO.inspect(client_key)
    IO.inspect(received_response)
    Logger.info("received response")
    Logger.info(Kernel.inspect(client_key))
    Logger.info(Kernel.inspect(received_response))
  end



  def receive_error(reason, key) do
    IO.inspect(key)
    IO.inspect(reason)
    Logger.info("received an error")
    Logger.info(Kernel.inspect(reason))
    Logger.info(Kernel.inspect(key))
  end
end
