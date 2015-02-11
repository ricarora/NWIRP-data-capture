Rails.application.routes.draw do
  resources :removability_grounds, param: :name

  devise_for :users

  resources :clients do
    collection { post :search, to: 'clients#index' }
    resources :convictions
    match 'advanced_search' => 'clients#advanced_search',
          on: :collection, via: [:get, :post], as: :advanced_search
  end

  root to: "home#index"

end
