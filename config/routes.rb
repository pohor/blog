Rails.application.routes.draw do
  devise_for :users
  root 'articles#index'
  get 'articles/index'

  # get 'articles', to: 'articles#index'
  # get 'articles/new', to: 'articles#new', as: 'new_article'
  # post 'articles', to: 'articles#create'
  # get 'articles/:id', to: 'articles#show', as: 'article'
  # get 'articles/:id/edit', to: 'articles#edit', as: 'edit_article'
  # patch 'articles/:id', to: 'articles#update'
  # delete 'articles/:id', to: 'articles#destroy' - resources generuje to wszystko

  resources :articles do
    get 'toggle_visibility', on: :member
    get 'most_commented', on: :member
    resources :comments do
      resources :scores, only: %i[create destroy]
    end
    resources :likes, only: %i[create destroy]
  end

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
