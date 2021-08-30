defmodule MyCore do
  use Sippet.Core
  require Logger


  def receive_request(received_request, server_key) do
    Logger.info("received request")
    IO.inspect(server_key)
    IO.inspect(received_request)
    #Logger.info(Kernel.inspect(server_key))
    #Logger.info(Kernel.inspect(received_request))

    request = Map.get(received_request, :headers)
    case request[:cseq] do
      {_, :register} ->
        Logger.info("Received REGISTER request")
        #branch_via = request[:branch]
        #tag1 = request[:from]
        #{_, _, tag_from} = tag1
        #tag2 = request[:to]
        #{_, _, tag_to} = tag2
        outgoing_response = received_request |> Sippet.Message.to_response(200)
        Sippet.send(:project, outgoing_response)


      {_, :invite} ->
        Logger.info("Received INVITE request")
        #outgoing_response = received_request |> Sippet.Message.to_response(100) # 100 - Trying
        #Sippet.send(:project, outgoing_response)
        #outgoing_response = received_request |> Sippet.Message.to_response(180) # 180 - Ringing
        #Sippet.send(:project, outgoing_response)

        outgoing_response = received_request |> Sippet.Message.to_response(200) # 200 - Ok

        Sippet.send(:project, outgoing_response)
        #Logger.info(Kernel.inspect(Sippet.send(:project, outgoing_response)))
        #Sippet.Message.build_response(200)

      _ ->
        Logger.info("Received UNKNOWN request")

      end

  end


  def receive_response(received_response, client_key) do
    Logger.info("received response")
    IO.inspect(client_key)
    IO.inspect(received_response)
    #Logger.info(Kernel.inspect(client_key))
    #Logger.info(Kernel.inspect(received_response))

    response = Map.get(received_response, :headers)
    branch = response[:via]
    [{_, _, _, branch_map}] = branch
    tag = response[:from]
    {_, _, tag_from} = tag
    case response[:cseq] do
      {_, :register} ->
        Logger.info("Received REGISTER response")
        Sippet.send(:project, SenReq.send_inv_request(response[:call_id], Map.get(branch_map, "branch"),  Map.get(tag_from, "tag")))


      {_, :invite} ->
        Logger.info("Received INVITE response")


      _ ->
        Logger.info("Received UNKNOWN response")

      end
  end



  def receive_error(reason, key) do
    Logger.info("received an error")
    IO.inspect(key)
    IO.inspect(reason)
    #Logger.info(Kernel.inspect(reason))
    #Logger.info(Kernel.inspect(key))
  end
end
