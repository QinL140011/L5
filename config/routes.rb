Rails.application.routes.draw do
  resources :users do
    resource :profile
  end
  resources :tweets
  resources :likes
  
  get "top/main"
  get "top/login"
  post "top/login"
  get "top/logout"
  root 'top#main'
end
