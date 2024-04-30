Rails.application.routes.draw do
  root to: 'books#index'
  devise_for :users
  resources :books
  resources :users, only: %i(index show)
  resources :reports, :books do
    resources :messages, only: %i(create edit update destroy), shallow: true
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
