Rails.application.routes.draw do
  resources :todos
  root to: "todos#index"
  get "follow", to: "dev#follow"
  get "立即預約", to: "dev#order_begin"
  get "平台簡介", to: "dev#follow"
  get "[服務種類] (*type)", to: "dev#service_type"
  get "[服務類型] (*type)", to: "dev#service_select"
  get "[選擇地址] (*location)", to: "dev#service_location"
  get "[設定地址] (*location)", to: "dev#set_location"
  get "[聯絡技師] (*line_id)", to: "dev#contact"
  get "[結束諮詢] (*line_id)", to: "dev#close_contact"
  get "結束諮詢", to: "dev#close_contact"
  get "[接受諮詢] (*line_id)", to: "dev#accept_contact"
  get "[接受訂單] (*line_id)", to: "dev#accept_order"
  get "[技師資訊] (*line_id)", to: "dev#technician_information"
  get "[完成訂單] (*state)", to: "dev#finish_order"
  get "送出訂單", to: "dev#submit_order"
  get "完成訂單", to: "dev#check_finish_order"
  get "test", to: "dev#test"
  get "service_technician", to: "dev#service_technician"
  post "create_comment", to: "dev#create_comment"
  get "new_comment", to: "dev#new_comment"
  post "create_technician", to: "dev#create_technician"
  get "new_technician", to: "dev#new_technician"

  post "create_order", to: "dev#create_order"
  get "new_order/:line_id", to: "dev#new_order"

  post "create_user", to: "dev#create_user"
  get "new_user", to: "dev#new_user"

  get "天氣分析", to: "shooly#weather"
  get "客服電話", to: "shooly#service"
  get "精選文章", to: "shooly#news"
  get "取得天氣", to: "shooly#getweather"

  get "liff_entry", to: "liff#entry"
  post "liff_route", to: "liff#route"
  get "(*other)", to: "dev#other"
  # # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: "todos#index"
  # get "個人資料",to: "shooly#profile"
  # get "test",to: "todos#test0"
  # get "我同意Shooly條款", to: "shooly#platform_introduction"
  # get "follow", to: "shooly#platform_introduction"
  # #get "(*date)(*location)天氣", to: "weather#show"
  # #get "(*location)天氣(*other)", to: "weather#show"
  # get "立即預約", to: "shooly#service_type"
  # get "水電維修", to: "shooly#service_plumber"
  # get "居家清潔", to: "shooly#service_home_wash"
  # get "清洗", to: "shooly#service_wash"
  # get "其他", to: "shooly#service_other"
  # get "選擇 (*type)", to: "shooly#service_content"
  # get "地區 (*location1)", to: "shooly#location1"
  # get "縣市 (*location2)", to: "shooly#location2"
  # get "(*location)號", to: "shooly#location"
  # get "(*location)號(*location1)", to: "shooly#location"
  # get "選擇技師 (*technician)", to: "shooly#technician"
  # get "平台簡介", to: "shooly#platform_introduction"
  # get "鄉鎮 (*location3)", to: "shooly#location3"
  # get "確認訂單", to: "shooly#order"
  # get "服務態度(*comment)", to: "shooly#effectiveness"
  # get "效率(*comment)", to: "shooly#technology"
  # get "技術＆專業度(*comment)", to: "shooly#price"
  # get "價錢合理程度(*comment)", to: "shooly#comment"
  # get "付款方式(*pay)", to: "shooly#pay"
  # get "完成訂單", to: "shooly#finish_order"
  # get "技師資訊 (*technician)", to: "shooly#technician_information"
  # get "聯絡技師 (*technician)", to: "shooly#contact"
  # get "結束諮詢", to: "shooly#end_contact"
  # get "取消", to: "shooly#thanks"
  # get "查看技師目前位置", to: "shooly#map"
  # get "map", to: "shooly#map"
  # get "/0", to: "shooly#privacy"
  # get "/1", to: "shooly#order_information"
  # get "/2", to: "shooly#service_home_wash"
  # get "/3", to: "shooly#service_type"
  # get "/4", to: "shooly#service_location"
  # get "/5", to: "shooly#service_other"
  # get "/6", to: "shooly#service_plumber"
  # get "/7", to: "shooly#comment_technician"
  # get "/8", to: "shooly#service_time"
  # get "/9", to: "shooly#service_wash"
  # get "/10", to: "shooly#technician_information"
  # get "/11", to: "shooly#service_technician"
  # get "/12", to: "shooly#pay"
  get "liff_entry", to: "liff#entry"
  post "liff_route", to: "liff#route"
  # get "(*other)", to: "shooly#other"
end
