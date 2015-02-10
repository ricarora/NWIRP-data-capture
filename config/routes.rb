Rails.application.routes.draw do
  resources :removability_grounds, param: :name

  devise_for :users

  resources :clients do
    resources :convictions
  end

  root to: "home#index"

end
