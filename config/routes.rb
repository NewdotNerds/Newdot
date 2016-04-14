require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admin/sessions' }
  root "dashboards#show"
  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :users, only: [:show, :edit, :update] do
    resources :recommended_posts, only: [:index]
  end
  
  resources :posts, except: [:index] do
    resources :responses, only: [:create]
    resources :likes, only: [:create, :destroy], module: :posts
    resources :bookmarks, only: [:create, :destroy], module: :posts
  end

  resources :responses, only: [] do
    resources :likes, only: [:create, :destroy], module: :responses
    resources :bookmarks, only: [:create, :destroy], module: :responses
  end

  resources :tags, only: [:show]

  get "me/bookmarks" => "dashboards#bookmarks", as: :dashboard_bookmarks
  get "top-stories" => "dashboards#top_stories", as: :top_stories
  get "me/stories/drafts" => "stories#drafts", as: :stories_drafts
  get "me/stories/public" => "stories#published", as: :stories_published
  get "search" => "search#show", as: :search
  get "autocomplete" => "search#autocomplete", as: :autocomplete

  namespace :admin do
    resource :dashboard, only: [:show]
    resources :featured_tags, only: [:create, :destroy]
  end

  namespace :api do
    resources :notifications, only: [:index] do
      collection do
        post :mark_as_read
      end
    end

    resources :posts, only: [:create, :update, :destroy]

    post    "relationships" => "relationships#create"
    delete  "relationships" => "relationships#destroy"
    post    "interests" => "interests#create"
    delete  "interests" => "interests#destroy"
  end

  authenticate :admin do
    mount Sidekiq::Web => '/sidekiq'
  end
end
