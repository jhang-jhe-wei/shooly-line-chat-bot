Kamigo::Events::BasicEvent.class_eval do
  attr_accessor :params

  def platform_params
    {
      platform_type: platform_type,
      source_type: source_type,
      source_group_id: source_group_id,
      source_user_id: source_user_id,
      source_params: params,
    }
  end
end
Kamigo::EventParsers::LineEventParser.class_eval do
  def parse(event)
    payload = JSON.parse(event.to_json, symbolize_names: true)[:src]
    line_event = Kamigo::Events::LineEvent.new
    line_event.payload = payload
    line_event.reply_token = event["replyToken"]
    line_event.source_type = payload.dig(:source, :type)
    line_event.source_group_id = payload.dig(:source, :groupId) || payload.dig(:source, :roomId) || payload.dig(:source, :userId)
    line_event.source_user_id = payload.dig(:source, :userId) || payload.dig(:source, :groupId) || payload.dig(:source, :roomId)
    line_event.message_type = payload.dig(:message, :type) || payload.dig(:type)
    line_event.params = payload.dig(:postback, :params)
    line_event.message = payload.dig(:message, :text) || payload.dig(:postback, :data) || payload.dig(:message, :address) || line_event.message_type
    line_event
  end
end
