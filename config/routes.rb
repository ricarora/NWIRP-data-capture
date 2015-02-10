Rails.application.routes.draw do
  resources :removability_grounds, param: :name

  devise_for :users

  resources :clients do
    collection { post :search, to: 'clients#index' }
    resources :convictions
  end

  root to: "home#index"

end
