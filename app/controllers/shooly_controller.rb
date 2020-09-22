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
    render "weather/show"
  end

  def techcian_information
    @technician = params[:technician]
  end

  def finish_order
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
    render "shooly/location2"
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
