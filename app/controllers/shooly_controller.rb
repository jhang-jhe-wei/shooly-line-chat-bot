require "uri"

class ShoolyController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :debug_info
  before_action :privacy_read?, except: [:accept]

  def contact
    @user.technician = params[:technician]
    @user.save
  end

  def getweather
    puts "in get wather controller"
    @date = DateTime.parse(params[:source_params][:datetime])
    uri = URI("https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-091?Authorization=CWB-583F2494-D964-4D6F-9F4F-71151DE1529A&elementName=WeatherDescription&fbclid=IwAR2hvYZDDkXSFVhm1ft02tgfiSHrapJdQyzGCwRWzs0kGH1MIAzHvZwAAuo")
    response = Net::HTTP.get(uri).force_encoding("UTF-8") # => String
    s = JSON.parse response
    value = ""
    puts "location: #{@user.location2}"
    puts "date: #{@date.strftime("%Y-%m-%d")} 06:00:00"
    s["records"]["locations"][0]["location"].each do |item|
      if item["locationName"] == @user.location2
        item["weatherElement"][0]["time"].each do |element|
          if element["startTime"].== "#{@date.strftime("%Y-%m-%d")} 06:00:00"
            value = element["elementValue"][0]["value"]
          end
        end
      end
    end
    @str = value
    puts "value: #{value}"
    value.split("。").each do |item|
      if item.include?("降雨機率")
        value = item.delete("降雨機率 ").delete("%").to_i
        if value <= 10
          @str = "喔嗨呦，#{@date.strftime("%m/%d ")}的天氣晴，降雨機率#{value}%，很適合清洗水塔、洗冷氣室外機以及一般水電修繕唷～"
        elsif value <= 20
          @str = "喔嗨呦，#{@date.strftime("%m/%d ")}的天氣晴，降雨機率#{value}%，很適合清洗水塔、洗冷氣室外機以及一般水電修繕唷～"
        elsif value <= 30
          @str = "喔嗨呦，#{@date.strftime("%m/%d ")}的天氣晴，降雨機率#{value}%，很適合清洗水塔、洗冷氣室外機以及一般水電修繕唷～"
        elsif value <= 40
          @str = "喔嗨呦，#{@date.strftime("%Y-%m-%d ")}可能會下雨，降雨機率#{value}%，出門請記得帶雨傘，建議不要從事戶外修繕工作"
        elsif value <= 50
          @str = "喔嗨呦，#{@date.strftime("%Y-%m-%d ")}可能會下雨，降雨機率#{value}%，出門請記得帶雨傘，建議不要從事戶外修繕工作"
        elsif value <= 60
          @str = "喔嗨呦，#{@date.strftime("%Y-%m-%d ")}有很大的機會會下雨，降雨機率#{value}%，雨勢偏大，出門請小心道路安全，今天適合檢查室內漏水以及屋內滲水情形！但是建議不要從事戶外修繕工作以及戶外配電工作"
        elsif value <= 70
          @str = "喔嗨呦，#{@date.strftime("%Y-%m-%d ")}有很大的機會會下雨，降雨機率#{value}%，雨勢偏大，出門修繕請小心道路安全，今天適合檢查室內漏水以及屋內滲水情形！但是建議不要從事戶外修繕工作以及戶外配電工作"
        elsif value <= 80
          @str = "喔嗨呦，#{@date.strftime("%Y-%m-%d ")}有很大的機會會下雨，降雨機率#{value}%，雨勢偏大，出門修繕請小心道路安全，今天適合檢查室內漏水以及屋內滲水情形！但是建議不要從事戶外修繕工作以及戶外配電工作"
        elsif value <= 90
          @str = "喔嗨呦，#{@date.strftime("%Y-%m-%d ")}有很大的機會會下雨，降雨機率#{value}%，雨勢偏大，出門修繕請小心道路安全，今天適合檢查室內漏水以及屋內滲水情形！但是建議不要從事戶外修繕工作以及戶外配電工作"
        else
          @str = "喔嗨呦，#{@date.strftime("%Y-%m-%d ")}有很大的機會會下雨，降雨機率#{value}%，雨勢偏大，出門修繕請小心道路安全，今天適合檢查室內漏水以及屋內滲水情形！但是建議不要從事戶外修繕工作以及戶外配電工作"
        end
      end
    end
    render "weather/show"
  end

  def map
  end

  def weather
    if @user.location2
      render "shooly/weather"
    else
      @str = "請先進行預約後才可以使用此功能唷~"
      render "weather/show"
    end
  end

  def technician_information
    @technician = params[:technician]
  end

  def finish_order
    line.push_message(params[:source_user_id], { "type": "text", "text": "請問您給小虎幾顆星評價呢？\n您的評價將幫助其他用戶挑選技師喔！" })
    render "shooly/comment_technician"
  end

  def pay
    render "shooly/finish_order"
  end

  def comment
    @user.service_step = "1"
    @user.save
  end

  def service_technician
    @name = "wells"
  end

  def order
    PushMessageToLineJob.set(wait: 1.minutes).perform_later(params[:source_user_id])
  end

  def other
    puts @user.service_step
    if params["source_params"]["datetime"].present?
      @user.time = DateTime.parse(params[:source_params][:datetime])
      @user.save
      render "shooly/order_information"
    else
      puts params[:source_params]
    end
    if @user.service_step.present?
      @user.service_step = nil
      @user.save
      render "shooly/thanks.line.erb"
    end
    if @user.name_flag.present?
      @user.name_flag = nil
      @user.name = params[:other]
      @user.phone_flag = "1"
      @user.save
      render "shooly/phone"
    elsif @user.phone_flag.present?
      @user.phone_flag = nil
      @user.phone = params[:other]
      @user.save
      line.push_message(params[:source_user_id], { "type": "text", "text": "Shooly 幫你找了目前可以為您服務的技師喔！" })
      render "shooly/service_technician"
    end
  end

  def service_content
    @user.content = params[:type]
    @user.save
    render "shooly/location1"
  end

  def location1
    @user.location1 = params[:location1]
    @user.save
    case params[:location1]
    when "北區"
      render "shooly/location_north"
    when "中區"
      render "shooly/location_west"
    when "南區"
      render "shooly/location_south"
    when "東區"
      render "shooly/location_east"
    end
  end

  def location2
    @user.location2 = params[:location2]
    @user.save
    case params[:location2]
    when "新竹市" then render "shooly/Hsinchu_City"
    when "新北市" then render "shooly/NewTaipei_City"
    when "基隆市" then render "shooly/Keelung_City"
    when "雲林縣" then render "shooly/Yunlin_Country"
    when "高雄市" then render "shooly/Kaohsiung_City"
    when "桃園市" then render "shooly/Taoyuan_City"
    when "苗栗縣" then render "shooly/Miaoli_Country"
    when "屏東縣" then render "shooly/Pingtung_Country"
    when "南投縣" then render "shooly/Nantou_Country"
    when "花蓮縣" then render "shooly/Hualien_Country"
    when "宜蘭縣" then render "shooly/Yilan_Country"
    when "台南市" then render "shooly/Tainan_City"
    when "台東縣" then render "shooly/Taitung_Country"
    when "台北市" then render "shooly/Taipei_City"
    when "台中市" then render "shooly/Taichung_City"
    when "彰化縣" then render "shooly/Changhua_Country"
    when "嘉義縣" then render "shooly/Chiayi_Country"
    when "嘉義市" then render "shooly/Chiayi_City"
    when "新竹縣" then render "shooly/Hsinchu_Country"
    end
  end

  def location3
    @user.location3 = params[:location3]
    @user.name_flag = "1"
    @user.save
    render "shooly/name"
  end

  def technician
    @user.technician = params[:technician]
    @user.save
    render "shooly/service_location"
  end

  def location
    if params[:location1].present?
      @user.location = params[:location] + "號" + params[:location1]
      @user.save
      puts params[:location] + "號" + params[:location1]
    else
      @user.location = params[:location] + "號"
      @user.save
      puts params[:location] + "號"
    end
    render "shooly/service_time"
  end

  def accept
    @user = User.find_by line_id: params[:source_user_id]
    @user.privacy_flag = true
    @user.save
  end

  def privacy_read?
    @user = User.find_by line_id: params[:source_user_id]
    if @user.nil?
      User.create(line_id: params[:source_user_id])
      render "shooly/privacy"
    elsif @user.privacy_flag
    else
      render "shooly/privacy"
    end
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
      config.channel_secret = "d90f297390fb8b1769e3e625ccf56828"
      config.channel_token = "5T+wLKjPrwD5aeANK/A0dM9Z/+QS5Cw1K95jUoKkDefEWY3DtEwI57cX+nHqDtiP7PyMlH/i45lXG6fqdpeEFSXEkKYOS6RJi9fP1/9VEnA7N9IGbb6Xoz7peYyPONK9mco3XectB5C+MLDsag2/jAdB04t89/1O/w1cDnyilFU="
    }
  end
end
