class Alert
  def self.send(message)
    twilio_client = TwilioInterface.new
    twilio_client.send(message)
  end
end
