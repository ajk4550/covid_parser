class TwilioInterface
  def send(message)
    # Fetch Twilio auth info from Rails credentials
    account_sid = Rails.application.credentials.twilio[:account_sid]
    auth_token = Rails.application.credentials.twilio[:auth_token]

    # set up a client to talk to the Twilio REST API
    client = Twilio::REST::Client.new account_sid, auth_token
    client.messages.create(
      from: '+12513602339',
      to: '+15852815098',
      body: message
    )
  end
end
