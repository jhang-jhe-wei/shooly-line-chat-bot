Rails.application.routes.draw do
  resources :todos
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "todos#index"
  get "我同意Shooly條款", to: "shooly#accept"
  get "天氣分析", to: "shooly#weather"
  get "(*date)(*location)天氣", to: "weather#show"
  get "(*location)天氣(*other)", to: "weather#show"
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
