# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :press_services
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root 'main#index'
  get 'calendar', to: 'games#calendar'
  get 'cup', to: 'tournaments#cup'
  get 'championship', to: 'tournaments#championship'
  get 'games_archive', to: 'games#archive'
  get 'games_archive/search', to: 'games#archive_search'

  resources :articles, :players, :coaches, :albums
  resources :teams, except: %i[show destroy]
  resources :tournaments, except: :destroy
  resources :tournament_teams, only: %i[new create destroy]
  resources :stadia, except: %i[show destroy]
  resources :games, except: :index
  resources :videos, except: :show
  resources :game_videos, only: %i[new create destroy]
  resources :game_albums, only: %i[new create destroy]
end
