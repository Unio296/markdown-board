Rails.application.routes.draw do
  #twitter認証
  get '/auth/:provider/callback', to: 'sessions#create', as: 'twitter_login'
  get '/logout', to: 'sessions#destroy'

  #静的ページRoutes
  root "static_pages#home"
  get '/terms' ,to: "static_pages#terms" 
  get '/privacy', to: "static_pages#privacy"
  get '/contact', to: "static_pages#contact"
  
  #ユーザのRoutes
  resources :users, param: :nickname
end
