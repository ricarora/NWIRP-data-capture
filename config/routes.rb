Rails.application.routes.draw do
  get '/advanced_search', to: 'queries#advanced_search'
  post '/advanced_search', to: 'queries#advanced_search'

  resources :removability_grounds, param: :name

  devise_for :users

  resources :clients do
    collection do
      get 'find'
    end
    member do
      get 'assessment/:assessment_id', to: 'clients#destroy_assessment', as: :destroy_assessment
    end
    resources :convictions

  end

  root to: "home#index"

end
