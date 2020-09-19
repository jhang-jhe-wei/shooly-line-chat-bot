class ShoolyController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :debug_info
  before_action :privacy_read?

  def service_technician
    @name = "wells"
  end

  def accept
    @user = User.find_by line_id: params[:source_user_id]
    @user.privacy_flag = true
    @user.save
  end

  def privacy_read?
    @user = User.find_by line_id: params[:source_user_id]
    if @user.nil?
      render "shooly/privacy"
      return false
    elsif @user.privacy_flag
      return true
    end
    render "shooly/privacy"
    return false
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
