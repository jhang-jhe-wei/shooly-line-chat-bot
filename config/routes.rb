Rails.application.routes.draw do
  resources :todos
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "todos#index"
  get "我同意Shooly條款", to: "shooly#accept"
  get "天氣分析", to: "shooly#weather"
  get "(*date)(*location)天氣", to: "weather#show"
  get "(*location)天氣(*other)", to: "weather#show"
  get "精選文章", to: "shooly#news"
  get "立即預約", to: "shooly#service_type"
  get "水電維修", to: "shooly#service_plumber"
  get "居家清潔", to: "shooly#service_home_wash"
  get "清洗", to: "shooly#service_wash"
  get "其他", to: "shooly#service_other"
  get "選擇 (*type)", to: "shooly#service_content"
  get "地區 (*location1)", to: "shooly#location1"
  get "縣市 (*location2)", to: "shooly#location2"
  get "(*location)號", to: "shooly#location"
  get "/0", to: "shooly#privacy"
  get "/1", to: "shooly#order_information"
  get "/2", to: "shooly#service_home_wash"
  get "/3", to: "shooly#service_type"
  get "/4", to: "shooly#service_location"
  get "/5", to: "shooly#service_other"
  get "/6", to: "shooly#service_plumber"
  get "/7", to: "shooly#comment_technician"
  get "/8", to: "shooly#service_time"
  get "/9", to: "shooly#service_wash"
  get "/10", to: "shooly#technician_information"
  get "/11", to: "shooly#service_technician"
end
