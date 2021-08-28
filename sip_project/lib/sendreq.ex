defmodule SenReq do
  def send_request do
    request =
      """
      REGISTER sip:192.168.50.71 SIP/2.0
      Via: SIP/2.0/UDP 192.168.50.71:5060;branch=#{Sippet.Message.create_branch()}
      From: <sip:9001@192.168.50.71>;tag=#{Sippet.Message.create_tag()}
      To: <sip:9002@192.168.50.71>
      CSeq: 1 REGISTER
      User-Agent: Sippet/1.0
      Call-ID: #{Sippet.Message.create_call_id()}
      Contact: <sip:9002@192.168.50.71:5060>
      Expires: 300
      """ |> Sippet.Message.parse!()

    request
  end

end
