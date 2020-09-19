class ShoolyController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :debug_info
  before_action :privacy_read?, except: [:accept]

  def service_technician
    @name = "wells"
  end

  def plumber
    request.env["PATH_INFO"]
    render "shooly/location1"
  end

  def wash
    request.env["PATH_INFO"]
    render "shooly/location1"
  end

  def home_wash
    request.env["PATH_INFO"]
    render "shooly/location1"
  end

  def other
    request.env["PATH_INFO"]
    render "shooly/location1"
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
