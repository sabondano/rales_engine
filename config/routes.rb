Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/find',     to: 'merchants#find'
      get '/customers/find',     to: 'customers#find'
      get '/invoice_items/find', to: 'invoice_items#find'
      get '/invoices/find',      to: 'invoices#find'
      get '/items/find',         to: 'items#find'
      get '/transactions/find',  to: 'transactions#find'

      resources :customers,     only: [:show]
      resources :merchants,     only: [:show]
      resources :items,         only: [:show]
      resources :invoices,      only: [:show]
      resources :transactions,  only: [:show]
      resources :invoice_items, only: [:show]

    end
  end
end
