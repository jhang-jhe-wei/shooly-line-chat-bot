class DevController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :debug_info
    before_action :init
  def follow
  end

  def test
    response = line.get_profile @user.line_id
    puts "----------------------test#{response.body}"
  end
  def create_order
    render "dev/check_order"
  end

  def new_order
  end

  def new_technician
  end

  def create_technician
    technician = Technician.find_by line_id: params[:source_user_id]
    if technician.nil?
      Technician.create line_id: params[:source_user_id],name: params[:name],location: params[:location]
    end
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
    line.push_message(@user.contact_id, { "type": "text", "text": "[結束諮詢]" })
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
        render "dev/check_location"
      end
      
      if @user.contact_flag
        line.push_message(@user.contact_id, { "type": "text", "text": "#{params[:other]}" })
        render "dev/space"
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
