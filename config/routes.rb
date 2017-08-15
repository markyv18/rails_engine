Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants
      get '/merchants/:id/revenue', to: 'merchants#revenue'
      resources :customers
      resources :transactions
    end
  end
end
