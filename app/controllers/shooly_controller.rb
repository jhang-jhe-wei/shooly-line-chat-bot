class ShoolyController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :debug_info
  before_action :privacy_read?, except: [:accept]

  def service_technician
    @name = "wells"
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
    render "shooly/service_technician"
  end

  def technician
    @user.technician = params[:technician]
    @user.save
    render "shooly/service_location"
  end

  def location
    @user.location = params[:location] + "號"
    @user.save
    puts params[:location] + "號"
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
    puts "=== kamigo debug info end ==="
    puts ""
  end
end
