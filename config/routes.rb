# frozen_string_literal: true

Rails.application.routes.draw do
  # scope "(:locale)", locale: /#{I18n.available_locales.map(&:to_s).join("|")}/ do
  resources :books, path: '(:locale)/books',
                    locale: /#{I18n.available_locales.map(&:to_s).join("|")}/
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
