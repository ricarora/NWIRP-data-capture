# Copyright (c) 2015 Richa Arora and Kate Fulton All Rights Reserved.

Rails.application.routes.draw do
  get '/saved_queries', to: 'queries#index', as: :saved_queries
  get '/advanced_search', to: 'queries#advanced_search', as: :advanced_search
  post '/advanced_search', to: 'queries#advanced_search'
  post '/create', to: 'queries#create', as: :queries
  get '/advanced_search/:id', to: 'queries#show', as: :advanced_search_show
  delete '/saved_queries', to: 'queries#destroy', as: :delete_query

  resources :removability_grounds, param: :name
  resources :relief_soughts, param: :name

  devise_for :users#, path_names: {sign_in: "login", sign_out: "logout"}

  resources :users

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
