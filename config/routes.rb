Rails.application.routes.draw do
  root to: 'books#index'
  devise_for :users
  resources :books
  resources :users, only: %i(index show)
  
  resources :reports do
    resources :messages, only: %i(create), shallow: true
  end
  resources :messages, only: %i(destroy)
  
  resources :books do
    resources :messages, only: %i(create), shallow: true
  end
  resources :messages, only: %i(destroy)

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
