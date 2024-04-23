Rails.application.routes.draw do
  root to: 'books#index'
  devise_for :users
  resources :books
  resources :users, only: %i(index show)
  resources :reports do
    resources :messages, only: %i(create destroy)
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
