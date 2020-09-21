class PushMessageToLineJob < ApplicationJob
  queue_as :default

  def perform(line_id)
    # Do something later
    push_message(line_id, { "type": "text", "text": "您預約的技師約在5分鐘後到達!" })
  end

  def line
    @line ||= Line::Bot::Client.new { |config|
      config.channel_secret = "d90f297390fb8b1769e3e625ccf56828"
      config.channel_token = "5T+wLKjPrwD5aeANK/A0dM9Z/+QS5Cw1K95jUoKkDefEWY3DtEwI57cX+nHqDtiP7PyMlH/i45lXG6fqdpeEFSXEkKYOS6RJi9fP1/9VEnA7N9IGbb6Xoz7peYyPONK9mco3XectB5C+MLDsag2/jAdB04t89/1O/w1cDnyilFU="
    }
  end
end
