Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admin/sessions' }
  root "dashboards#show"
  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :users, only: [:show, :edit, :update]
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
  resources :relationships, only: [:create, :destroy]
  resources :interests, only: [:create, :destroy]
  get "me/bookmarks" => "dashboards#bookmarks", as: :dashboard_bookmarks
  get "top-stories" => "dashboards#top_stories", as: :top_stories
  get "search" => "search#show", as: :search

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
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
