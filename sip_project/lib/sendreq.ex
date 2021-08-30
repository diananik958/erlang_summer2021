defmodule SenReq do
  def send_reg_request do
    request =
      """
      REGISTER sip:diana@192.168.50.71 SIP/2.0
      Via: SIP/2.0/UDP 192.168.50.71:5060;branch=#{Sippet.Message.create_branch()}
      Max-Forwards: 70
      From: <sip:diana@192.168.50.71>;tag=#{Sippet.Message.create_tag()}
      To: <sip:diana@192.168.50.46>
      Call-ID: #{Sippet.Message.create_call_id()}
      CSeq: 1 REGISTER
      Supported: replaces, outbound
      User-Agent: Sippet/1.0.9
      Allow: INVITE, ACK, CANCEL, OPTIONS, BYE, REFER, NOTIFY, MESSAGE, SUBSCRIBE, INFO, UPDATE
      Contact: <sip:diana@192.168.50.71:5060;transport=udp>
      ;+sip.instance="<urn:uuid:00000000-0000-1000-8000-000A95A0E128>"
      Content-Length: 0
      Expires: 7200
      """ |> Sippet.Message.parse!()

    request
  end

  def send_inv_request(call_id, branch, tag) do
    request =
      """
      INVITE sip:diana@192.168.50.71 SIP/2.0
      Via: SIP/2.0/UDP 192.168.50.71:5060;branch=#{branch}
      Max-Forwards: 70
      From: <sip:diana@192.168.50.71>;tag=#{tag}
      To: <sip:diana@192.168.50.46>
      Call-ID: #{call_id}
      CSeq: 20 INVITE
      Supported: replaces, outbound
      User-Agent: Sippet/1.0.9
      Allow: INVITE, ACK, CANCEL, OPTIONS, BYE, REFER, NOTIFY, MESSAGE, SUBSCRIBE, INFO, UPDATE
      Contact: <sip:diana@192.168.50.71:5060;transport=udp>


      """ |> Sippet.Message.parse!()

    request
  end

end
