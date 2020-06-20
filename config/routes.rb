Rails.application.routes.draw do
  post 'questions/activate', to: 'questions#activate'
  post 'questions/deactivate', to: 'questions#deactivate'
  post 'comments/activate', to: 'comments#activate'
  post 'comments/deactivate', to: 'comments#deactivate'
  post 'questions/import', to: 'questions#do_import'
  get 'questions/import', to: 'questions#import'
  get 'questions/filter'
  get 'comments/filter'
  get 'questions/index'

  resources :questions do
    resources :comments do
      resources :likes
    end
  end

  # resources :comments do
  #   resources :likes
  # end

  resources :questions do
    collection {post :import}
  end

  root 'questions#index', as: 'home'
  devise_for :users
  resources :questions do
    resources :comments
  end

  resources :comments

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
