class DevController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :debug_info
    before_action :init
  def follow
  end

  def new_comment
  end

  def create_comment
  end
  
  def accept_order
    puts "-------------#{params[:line_id]}"
    line.push_message(params[:line_id],
      {
      "type": "flex",
      "altText": "FIFA Home",
      "contents": { "type": "bubble", "direction": "ltr", "header": { "type": "box", "layout": "vertical", "contents": [{ "type": "text", "text": "您的訂單已建立", "weight": "bold", "size": "xl", "color": "#1969A4FF", "align": "center", "contents": [] }, { "type": "separator", "margin": "sm" }] }, "footer": { "type": "box", "layout": "vertical", "contents": [{ "type": "button", "action": { "type": "uri", "label": "查看技師位置", "uri": "#{ENV['LIFF_COMPACT']}/liff_entry?path=/todos/new" } },{ "type": "button", "action": { "type": "message", "label": "聯絡技師", "text": "[聯絡技師] #{@user.technician_line_id}" } }, { "type": "button", "action": { "type": "message", "label": "完成訂單", "text": "完成訂單" } }] } },
    })
  end
  
  def submit_order
    puts "----------------------#{@user.technician_line_id}"
    @order = Order.find_by user_line_id: @user.line_id,state: "init"
    getweather
    line.push_message(@user.technician_line_id, {
      "type": "flex",
      "altText": "FIFA Home",
      "contents": {
        "type": "bubble",
        "direction": "ltr",
        "header": {
          "type": "box",
          "layout": "vertical",
          "contents": [
            {
              "type": "text",
              "text": "您有訂單",
              "weight": "bold",
              "size": "xl",
              "color": "#0773D3FF",
              "align": "start",
              "contents": [],
            },
            {
              "type": "text",
              "text": "#{@order.time}",
              "color": "#A2A0A0FF",
              "margin": "lg",
              "contents": [],
            },
            {
              "type": "filler",
            },
            {
              "type": "separator",
              "margin": "sm",
            },
          ],
        },
        "body": {
          "type": "box",
          "layout": "vertical",
          "contents": [
            {
              "type": "box",
              "layout": "vertical",
              "spacing": "none",
              "contents": [
                {
                          "type": "box",
                          "layout": "vertical",
                          "contents": [
                            {
                              "type": "text",
                              "text": "預約人：",
                              "weight": "bold",
                              "color": "#0773D3FF",
                              "contents": [],
                            },
                            {
                              "type": "text",
                              "text": "#{@order.name}",
                              "weight": "bold",
                              "contents": [],
                            },
                          ],
                        },
                {
                          "type": "box",
                          "layout": "vertical",
                          "contents": [
                            {
                              "type": "text",
                              "text": "項目：",
                              "weight": "bold",
                              "color": "#0773D3FF",
                              "align": "start",
                              "contents": [],
                            },
                            {
                              "type": "text",
                              "text": "#{@order.content}",
                              "weight": "bold",
                              "align": "start",
                              "contents": [],
                            },
                          ],
                        },
                {
                          "type": "box",
                          "layout": "vertical",
                          "contents": [
                            {
                              "type": "text",
                              "text": "技師：",
                              "weight": "bold",
                              "color": "#0773D3FF",
                              "contents": [],
                            },
                            {
                              "type": "text",
                              "text": "#{(Technician.find_by line_id: @order.technician_line_id).name}",
                              "weight": "bold",
                              "contents": [],
                            },
                          ],
                        },
                {
                          "type": "box",
                          "layout": "vertical",
                          "contents": [
                            {
                              "type": "text",
                              "text": "地址：",
                              "weight": "bold",
                              "color": "#0773D3FF",
                              "contents": [],
                            },
                            {
                              "type": "text",
                              "text": "#{@order.location}",
                              "weight": "bold",
                              "contents": [],
                            },
                          ],
                        },
                {
                          "type": "box",
                          "layout": "vertical",
                          "contents": [
                            {
                              "type": "text",
                              "text": "電話號碼：",
                              "weight": "bold",
                              "color": "#0773D3FF",
                              "contents": [],
                            },
                            {
                              "type": "text",
                              "text": "#{@order.phone}",
                              "weight": "bold",
                              "contents": [],
                            },
                          ],
                        },
              {
                          "type": "box",
                          "layout": "vertical",
                          "contents": [
                            {
                              "type": "text",
                              "text": "天氣狀況：",
                              "weight": "bold",
                              "color": "#0773D3FF",
                              "contents": [],
                            },
                            {
                              "type": "text",
                              "text": "#{@weather}",
                              "wrap": true,
                              "weight": "bold",
                              "contents": [],
                            },
                          ],
                        },
              ],
            },
          ],
        },
        "footer": {
          "type": "box",
          "layout": "horizontal",
          "contents": [
            {
              "type": "button",
              "action": {
                "type": "message",
                "label": "接受訂單",
                "text": "[接受訂單] #{@user.line_id}"
              },
              "color": "#0AE0B1FF",
              "style": "primary",
            },
          ],
        },
      },
    }
  )
  end

  def getweather
    uri = URI::escape("https://maps.googleapis.com/maps/api/geocode/json?address=#{@order.location}&language=zh-TW&key=AIzaSyD3Wl3YZAA9886-c0Ita6q2229-j4Kz9kA")
    #uri = URI::escape("https://maps.googleapis.com/maps/api/geocode/json?address=106台灣台北市大安區台大公館醫院&language=zh-TW&key=AIzaSyD3Wl3YZAA9886-c0Ita6q2229-j4Kz9kA")
    uri = URI(uri)
    response = Net::HTTP.get(uri).force_encoding("UTF-8")
    json = JSON.parse response

    uri = URI("https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-091?Authorization=CWB-583F2494-D964-4D6F-9F4F-71151DE1529A&elementName=WeatherDescription&fbclid=IwAR2hvYZDDkXSFVhm1ft02tgfiSHrapJdQyzGCwRWzs0kGH1MIAzHvZwAAuo")
    response = Net::HTTP.get(uri).force_encoding("UTF-8") # => String
    s = JSON.parse response
    # puts s
    @weather = "目前無法預測"
    s["records"]["locations"][0]["location"].each do |item|
      puts "------------------#{json["results"][0]["address_components"][2]["short_name"].sub("台","臺")}"
      if item["locationName"] == json["results"][0]["address_components"][2]["short_name"].sub("台","臺")
        puts "------------------test"
        item["weatherElement"][0]["time"].each do |element|
          # puts "----------------#{@order.time.strftime("%Y-%m-%d")} 06:00:00"
          puts element
          puts "#{@order.time.strftime("%Y-%m-%d")} 06:00:00"
          if element["startTime"].== "#{@order.time.strftime("%Y-%m-%d")} 06:00:00"
            @weather = element["elementValue"][0]["value"]
            return
          end
        end
      end
      if item["locationName"] == json["results"][0]["address_components"][3]["short_name"].sub("台","臺")
        puts "------------------test"
        item["weatherElement"][0]["time"].each do |element|
          # puts "----------------#{@order.time.strftime("%Y-%m-%d")} 06:00:00"
          puts element
          puts "#{@order.time.strftime("%Y-%m-%d")} 06:00:00"
          if element["startTime"].== "#{@order.time.strftime("%Y-%m-%d")} 06:00:00"
            @weather = element["elementValue"][0]["value"]
            puts"-------------------------#{@weather}"
            return
          end
        end
      end
    end
    puts"-------------------------#{@weather}"

  end
  def service_technician
    @technicians = Technician.all
  end


  def create_order
    @order = Order.find_by user_line_id: @user.line_id,state: "init"
    if @order.nil?
      @order = Order.new technician_line_id: @user.technician_line_id,phone: params[:fphone],content: @user.content,location: params[:flocation],time: DateTime.parse(params[:fdatetime].to_s),name: params[:fname],user_line_id: @user.line_id,state: "init"
    else
      @order.technician_line_id = @user.technician_line_id
      @order.phone = params[:fphone]
      @order.content = @user.content
      @order.location =  params[:flocation]
      @order.time = DateTime.parse(params[:fdatetime].to_s)
      @order.name = params[:fname]
    end
    @order.save
    @user.phone = params[:fphone]
    @user.name = params[:fname]
    @user.save

    uri = URI::escape("https://maps.googleapis.com/maps/api/geocode/json?address=#{@order.location}&language=zh-TW&key=AIzaSyD3Wl3YZAA9886-c0Ita6q2229-j4Kz9kA")
    #uri = URI::escape("https://maps.googleapis.com/maps/api/geocode/json?address=106台灣台北市大安區台大公館醫院&language=zh-TW&key=AIzaSyD3Wl3YZAA9886-c0Ita6q2229-j4Kz9kA")
    uri = URI(uri)
    response = Net::HTTP.get(uri).force_encoding("UTF-8")
    json = JSON.parse response

    uri = URI("https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-091?Authorization=CWB-583F2494-D964-4D6F-9F4F-71151DE1529A&elementName=WeatherDescription&fbclid=IwAR2hvYZDDkXSFVhm1ft02tgfiSHrapJdQyzGCwRWzs0kGH1MIAzHvZwAAuo")
    response = Net::HTTP.get(uri).force_encoding("UTF-8") # => String
    s = JSON.parse response
    # puts s
    @weather = "目前無法預測"
    s["records"]["locations"][0]["location"].each do |item|
      puts "------------------#{json["results"][0]["address_components"][2]["short_name"].sub("台","臺")}"
      if item["locationName"] == json["results"][0]["address_components"][2]["short_name"].sub("台","臺")
        puts "------------------test"
        item["weatherElement"][0]["time"].each do |element|
          # puts "----------------#{@order.time.strftime("%Y-%m-%d")} 06:00:00"
          puts element
          puts "#{@order.time.strftime("%Y-%m-%d")} 06:00:00"
          if element["startTime"].== "#{@order.time.strftime("%Y-%m-%d")} 06:00:00"
            @weather = element["elementValue"][0]["value"]
            render "dev/check_order"
            return
          end
        end
      end
      if item["locationName"] == json["results"][0]["address_components"][3]["short_name"].sub("台","臺")
        puts "------------------test"
        item["weatherElement"][0]["time"].each do |element|
          # puts "----------------#{@order.time.strftime("%Y-%m-%d")} 06:00:00"
          puts element
          puts "#{@order.time.strftime("%Y-%m-%d")} 06:00:00"
          if element["startTime"].== "#{@order.time.strftime("%Y-%m-%d")} 06:00:00"
            @weather = element["elementValue"][0]["value"]
            puts"-------------------------#{@weather}"
            render "dev/check_order"
            return
          end
        end
      end
    end
    puts"-------------------------#{@weather}"
    render "dev/check_order"
  end

  def new_order

    @user.technician_line_id = params[:line_id]
    @user.save
  end

  def new_technician
  end

  def create_technician
    @technician = Technician.find_by line_id: params[:source_user_id]
    if @technician.nil?      
      @technician = Technician.new
    end
    response = line.get_profile params[:source_user_id]
    json = JSON.parse response.body
    @technician.line_id = params[:source_user_id]
    @technician.name = params[:name]
    @technician.location = params[:location]
    @technician.phone = params[:phone]
    @technician.photo = json["pictureUrl"]
    @technician.save
  end

  def contact
    if @user.contact_id.nil?
      @user.contact_flag=true
      @user.contact_id=params[:line_id]
      @user.save
    end
    line.push_message(params[:line_id], {
      "type": "template",
      "altText": "this is a confirm template",
      "template": {
        "type": "confirm",
        "actions": [
          {
            "type": "message",
            "label": "同意",
            "text": "[接受諮詢] #{@user.line_id}"
          },
          {
            "type": "message",
            "label": "婉拒",
            "text": "[拒絕諮詢]"
          }
        ],
        "text": "有一位業主向您發出諮詢請求，您要同意嗎?"
      }
    })
    render "dev/wait_contact_accept"
  end

  def close_contact
    puts "---------------------in close contact"
    line.push_message(@user.contact_id, { "type": "text", "text": "[結束諮詢]" })
    @contact_user = User.find_by line_id: @user.contact_id
    @contact_user.contact_flag=false
    @contact_user.contact_id=nil
    @contact_user.save
    @user.contact_flag=false
    @user.contact_id=nil
    @user.save
  end

  def accept_contact
    if @user.contact_id.nil?
      @user.contact_flag=true
      @user.contact_id=params[:line_id]
      @user.save
      line.push_message(@user.contact_id, { "type": "text", "text": "現在開始可以通過Shooly進行諮詢哦！" })
    end
    render "accept_advisory"
  end

  def order_begin
    render "dev/service_type"
  end

  def service_type
    case params[:type]
    when "水電維修" then render "dev/service_plumber"
    when "居家清潔" then render "dev/service_home_wash"
    when "清洗" then render "dev/service_wash"
    when "其他" then render "dev/service_other"
    end
  end

  def service_select
    @user.content = params[:type]
    @user.location1 ||= "住家"
    @user.location2 ||= "常用地點"
    @user.save
    render "dev/service_location"
  end

  def service_location
    @technicians = Technician.all
    @s = {
      "type": "flex",
      "altText": "FIFA Home",
      "contents": {
        "type": "carousel",
        "contents": [
        ],
      },
    }
    i = 0
    @technicians.each do |item|
      @s[:contents][:contents][i] = {
        "type": "bubble",
        "hero": {
          "type": "image",
          "url": "#{item.photo}",
          "size": "full",
          "aspectRatio": "14:13",
          "aspectMode": "cover",
          "action": {
            "type": "uri",
            "label": "Line",
            "uri": "https://linecorp.com/",
          },
        },
        "body": {
          "type": "box",
          "layout": "vertical",
          "contents": [
            {
              "type": "text",
              "text": "#{item.name}",
              "weight": "bold",
              "size": "xl",
              "contents": [],
            },
            {
              "type": "box",
              "layout": "baseline",
              "margin": "md",
              "contents": [
                {
                        "type": "icon",
                        "url": "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gold_star_28.png",
                        "size": "sm",
                      },
                {
                        "type": "icon",
                        "url": "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gold_star_28.png",
                        "size": "sm",
                      },
                {
                        "type": "icon",
                        "url": "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gold_star_28.png",
                        "size": "sm",
                      },
                {
                        "type": "icon",
                        "url": "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gold_star_28.png",
                        "size": "sm",
                      },
                {
                        "type": "icon",
                        "url": "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gray_star_28.png",
                        "size": "sm",
                      },
                {
                        "type": "text",
                        "text": "4.0",
                        "size": "sm",
                        "color": "#999999",
                        "flex": 0,
                        "margin": "md",
                        "contents": [],
                      },
              ],
            },
            {
              "type": "box",
              "layout": "vertical",
              "spacing": "sm",
              "margin": "lg",
              "contents": [
                {
                        "type": "box",
                        "layout": "baseline",
                        "spacing": "sm",
                        "contents": [
                          {
                            "type": "text",
                            "text": "服務地區",
                            "size": "sm",
                            "color": "#AAAAAA",
                            "flex": 1,
                            "contents": [],
                          },
                          {
                            "type": "text",
                            "text": "#{item.location}",
                            "size": "sm",
                            "color": "#666666",
                            "flex": 3,
                            "wrap": true,
                            "contents": [],
                          },
                        ],
                      },
                {
                        "type": "box",
                        "layout": "baseline",
                        "spacing": "sm",
                        "contents": [
                          {
                            "type": "text",
                            "text": "服務時間",
                            "size": "sm",
                            "color": "#AAAAAA",
                            "flex": 1,
                            "contents": [],
                          },
                          {
                            "type": "text",
                            "text": "10:00 - 23:00",
                            "size": "sm",
                            "color": "#666666",
                            "flex": 3,
                            "wrap": true,
                            "contents": [],
                          },
                        ],
                      },
              ],
            },
          ],
        },
        "footer": {
          "type": "box",
          "layout": "vertical",
          "flex": 0,
          "spacing": "sm",
          "contents": [
            {
              "type": "button",
              "action": {
                "type": "message",
                "label": "一對一諮詢",
                "text": "[聯絡技師] #{item.line_id}",
              },
            },
            {
              "type": "button",
              "action": {
                "type": "message",
                "label": "技師資訊",
                "text": "[技師資訊] #{item.comment}",
              },
            },
            {
              "type": "button",
              "action": {
                "type": "uri",
                "label": "立即預約",
                "uri": "https://liff.line.me/1655118814-BJejkxKg/liff_entry?path=/new_order/#{item.line_id}",
              },
              "height": "sm",
              "style": "link",
            },
          ],
        },
      }
    i += 1
    end
    

    case params[:location]
    when "住家"
      @user.location_flag= 1
      @user.save
      render "dev/set_location"

    when "常用地點"
      @user.location_flag= 2
      @user.save
      render "dev/set_location"

    when "新增地點"
      @user.location_flag= 2
      @user.save
      render "dev/set_location"

    else  
      @technicians=Technician.all
      @user.location = params[:location]
      @user.save
      render "dev/service_technician"
    end
  end

  def set_location
    case params[:location]
    when "正確"
      case @user.location_flag
      when 1 then @user.location1 = @user.location
      when 2 then @user.location2 = @user.location 
      end
      @user.location_flag = 0
      @user.save
      @technicians=Technician.all
      render "dev/service_technician"
    when "重新輸入"
      render "dev/set_location"
    else render "dev/please_enter_location"
    end
  end

  def other
    puts "----------------------------in other"
      unless @user.location_flag == 0
        @user.location = params[:other]
        puts "------------other#{@user.location}"
        @user.save
        uri = URI::escape("https://maps.googleapis.com/maps/api/geocode/json?address=#{@user.location}&key=AIzaSyD3Wl3YZAA9886-c0Ita6q2229-j4Kz9kA")
        uri = URI(uri)
        response = Net::HTTP.get(uri).force_encoding("UTF-8")
        json = JSON.parse response
        @location = json["results"][0]["geometry"]["location"]
        render "dev/check_location"
      end
      
      if @user.contact_flag
        line.push_message(@user.contact_id, { "type": "text", "text": "#{params[:other]}" })
        render "dev/space"
      end

      if params[:other].include? "new_order?line_id="
        puts "-----------------------#{params[:other]}"
        @user.technician_line_id = params[:other].delete "new_order?line_id="
        @user.save
        render "dev/new_order"
      end
  end

  def init
    @user = User.find_by line_id: params[:source_user_id]
    @user ||= User.new line_id: params[:source_user_id],location_flag: 0
    @user.save
  end

  def debug_info
    puts ""
    puts "=== kamigo debug info start ==="
    puts "platform_type: #{params[:platform_type]}"
    puts "source_type: #{params[:source_type]}"
    puts "source_group_id: #{params[:source_group_id]}"
    puts "source_user_id: #{params[:source_user_id]}"
    puts "params: #{params}"
    puts "=== kamigo debug info end ==="
    puts ""
  end

  def line
    @line ||= Line::Bot::Client.new { |config|
      config.channel_secret = "6b3c2b3478595ae35fb2c4165560af47"
      config.channel_token = "eTm/jNJL/gzPKV1jZVU63A2w48ghuPBKddj+9AZ0OKtb1bNNBIWjb3cjTY0hjBbTs7Kj7UiThZW8dR8eyIbmAWbzqnq+XLw8GxIC860QO1lFzYE3oukLs3ezdonS7NEVFstnk9gxveiE+rdLvozsRgdB04t89/1O/w1cDnyilFU="
    }
  end
end
