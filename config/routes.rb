Rails.application.routes.draw do
  root "static_pages#home"
  get '/terms' ,to: "static_pages#terms" 
  get '/privacy', to: "static_pages#privacy"
  get '/contact', to: "static_pages#contact"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
