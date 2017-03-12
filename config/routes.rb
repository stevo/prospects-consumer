Rails.application.routes.draw do
  resource :dashboard, controller: :dashboard
  resources :prospects
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "dashboard#show"
end
