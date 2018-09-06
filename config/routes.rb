Rails.application.routes.draw do
  get 'users/new'
  root "static_pages#home"
  get '/terms' ,to: "static_pages#terms" 
  get '/privacy', to: "static_pages#privacy"
  get '/contact', to: "static_pages#contact"
  resources :users
end
