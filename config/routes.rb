Rails.application.routes.draw do
  get '/advance_search', to: 'search#advance_search'
  post '/advance_search', to: 'search#advance_search'

  resources :removability_grounds, param: :name

  devise_for :users

  resources :clients do

    resources :convictions

  end

  root to: "home#index"

end
