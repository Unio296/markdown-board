Rails.application.routes.draw do
  get 'inquiry/index'
  get 'inquiry/confirm'
  get 'inquiry/thanks'
  #twitter認証
  get '/auth/:provider/callback', to: 'sessions#create', as: 'auth_login'
  get '/logout', to: 'sessions#destroy'

  #静的ページRoutes
  root "static_pages#home"
  get '/terms' ,to: "static_pages#terms" 
  get '/privacy', to: "static_pages#privacy"
  
  get '/inquiry', to: 'inquiry#index'              # 入力画面
  post '/inquiry/confirm', to: 'inquiry#confirm'   # 確認画面
  post '/inquiry/thanks', to: 'inquiry#thanks'     # 送信完了画面

  #ユーザのRoutes
  resources :users, param: :nickname, only: [:new, :show, :destroy] do
    resources :posts, param: :slug do
      member do
        patch :published_true
        patch :published_false
      end
    end
  end

end
