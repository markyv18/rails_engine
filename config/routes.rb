Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :invoices do
        get "/find", to: "find#show"
        get "/find_all", to: "find#index"
        get "/random", to: "random#show"
        get '/:id/transactions', to: 'transactions#index'
        get '/:id/merchant', to: 'merchants#index'
        get '/:id/items', to: 'items#index'
        get '/:id/customer', to: 'customers#index'
        get '/:id/invoice_items', to: 'invoice_items#index'
      end

      namespace :items do
        get "/find", to: "find#show"
        get "/find_all", to: "find#index"
        get "/random", to: "random#show"
        get '/:id/invoice_items', to: 'invoice_items#show'
        get '/:id/merchant', to: 'merchants#show'
        get '/most_revenue', to: 'revenue#index'
      end

      namespace :invoice_items do
        get "/find", to: "find#show"
        get "/find_all", to: "find#index"
        get "/random", to: "random#show"
        get '/:id/invoice', to: 'invoices#show'
        get '/:id/item', to: 'items#show'
      end

      namespace :merchants do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random', to: 'random#show'
        # get '/merchants/:id/revenue', to: 'revenue#show'
        get '/:id/items', to: 'items#index'
        get '/:id/invoices', to: 'invoices#index'
      end

      namespace :customers do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random', to: 'random#show'
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/transactions', to: 'transactions#index'
        get '/:id/favorite_merchant', to: 'merchants#show'
      end

      namespace :transactions do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random', to: 'random#show'
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/invoice',  to: 'invoices#index'
      end

      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end
end
