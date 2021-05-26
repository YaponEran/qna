Rails.application.routes.draw do
  devise_for :users
  root to: "questions#index"

  resources :questions do
    resources :answers, shallow: true do
      patch :set_best, on: :member
    end
  end

  resources :attachments, only: :destroy
  resources :links, only: :destroy
  resources :rewards, only: :index

  get 'user', to: "users#show"

  mount ActionCable.server => '/cable'
end
