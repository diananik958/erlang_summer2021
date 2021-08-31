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

  def send_inv_request(call_id, tag) do
    request =
      """
      INVITE sip:diana@192.168.50.71 SIP/2.0
      Via: SIP/2.0/UDP 192.168.50.71:5060;branch=#{Sippet.Message.create_branch()}
      Max-Forwards: 70
      From: <sip:diana@192.168.50.71>;tag=#{tag}
      To: <sip:diana@192.168.50.46>
      Call-ID: #{call_id}
      CSeq: 20 INVITE
      Supported: replaces, outbound
      User-Agent: Sippet/1.0.9
      Allow: INVITE, ACK, CANCEL, OPTIONS, BYE, REFER, NOTIFY, MESSAGE, SUBSCRIBE, INFO, UPDATE
      Contact: <sip:diana@192.168.50.71:5060;transport=udp>
      Content-Type: application/sdp
      Content-Length: 158

      v=0
      o=Linphone 123456789 3.12 IN IP4 192.168.50.71
      s=Lin
      c=IN IP4 192.168.50.71
      t=0 0
      m=audio 5160 RTP/AVP 0 101
      a=rtpmap:101 telephone-event/8000
      a=fmtp:101 0-16
      a=sendrecv
      """ |> Sippet.Message.parse!()

    request
  end

end
