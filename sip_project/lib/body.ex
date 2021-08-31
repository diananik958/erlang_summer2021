defmodule Body do
  require Logger
   def insert_body(msg) do
    body = "v=0\r\no=Linphone 1630120310317 3 IN IP4 192.168.50.71\r\ns=Z\r\nc=IN IP4 192.168.50.71\r\nt=0 0\r\nm=audio 52600 RTP/AVP 0 101 8 3\r\na=rtpmap:101 telephone-event/8000\r\na=fmtp:101 0-16\r\na=sendrecv\r\n"
      Logger.info(Kernel.inspect(Kernel.is_map(msg)))
      Map.update!(msg, :body, fn _ -> body end)
      outgoing_msg = msg |> Sippet.Message.put_header(:content_length, byte_size(body))
      outgoing_msg = outgoing_msg |> Sippet.Message.put_header(:content_type, {{"application", "sdp"}, %{}})
      outgoing_msg
   end
end
