class CallbackData
  attr_reader :command, :data

  def initialize(payload)
    json_payload = JSON.parse(payload, symbolize_names: true)
    @command = json_payload[:command].to_sym
    @data = json_payload[:data]
  end
end
