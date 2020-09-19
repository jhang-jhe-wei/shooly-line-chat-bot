Rails.application.routes.draw do
  resources :todos
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "todos#index"
  get "/0", to: "todos#test0"
  get "1", to: "todos#test1"
  get "2", to: "todos#test2"
  get "3", to: "todos#test3"
  get "4", to: "todos#test4"
  get "5", to: "todos#test5"
  get "6", to: "todos#test6"
  get "7", to: "todos#test7"
  get "8", to: "todos#test8"
end
