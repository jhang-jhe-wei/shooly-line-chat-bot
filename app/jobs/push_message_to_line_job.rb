class PushMessageToLineJob < ApplicationJob
  queue_as :default

  def perform(line_id)
    # Do something later
    line.push_message(line_id, { "type": "text", "text": "提醒您 您預約的技師將在5分鐘內抵達" })
    line.push_message(line_id, {
      "type": "flex",
      "altText": "FIFA Home",
      "contents": { "type": "bubble", "direction": "ltr", "header": { "type": "box", "layout": "vertical", "contents": [{ "type": "text", "text": "付款方式", "weight": "bold", "size": "xl", "color": "#1969A4FF", "align": "center", "contents": [] }, { "type": "separator", "margin": "sm" }] }, "footer": { "type": "box", "layout": "vertical", "contents": [{ "type": "button", "action": { "type": "message", "label": "現金交易", "text": "付款方式 現金交易" } }, { "type": "button", "action": { "type": "message", "label": "Line Pay", "text": "付款方式 Line Pay" } }] } },
    })
  end

  def line
    @line ||= Line::Bot::Client.new { |config|
      config.channel_secret = "d90f297390fb8b1769e3e625ccf56828"
      config.channel_token = "5T+wLKjPrwD5aeANK/A0dM9Z/+QS5Cw1K95jUoKkDefEWY3DtEwI57cX+nHqDtiP7PyMlH/i45lXG6fqdpeEFSXEkKYOS6RJi9fP1/9VEnA7N9IGbb6Xoz7peYyPONK9mco3XectB5C+MLDsag2/jAdB04t89/1O/w1cDnyilFU="
    }
  end
end
