Rails.application.routes.draw do
  namespace :api do
    resources :articles, only: %i[create index]
  end
end
