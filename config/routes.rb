Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/find',     to: 'merchants#find'
      get '/customers/find',     to: 'customers#find'
      get '/invoice_items/find', to: 'invoice_items#find'
      get '/invoices/find',      to: 'invoices#find'
      get '/items/find',         to: 'items#find'
      get '/transactions/find',  to: 'transactions#find'

      get '/merchants/find_all',        to: 'merchants#find_all'
      get '/customers/find_all',        to: 'customers#find_all'
      get '/invoice_items/find_all',    to: 'invoice_items#find_all'
      get '/invoices/find_all',         to: 'invoices#find_all'
      get '/items/find_all',            to: 'items#find_all'
      get '/transactions/find_all',     to: 'transactions#find_all'

      resources :customers,     only: [:show]
      resources :merchants,     only: [:show]
      resources :items,         only: [:show]
      resources :invoices,      only: [:show]
      resources :transactions,  only: [:show]
      resources :invoice_items, only: [:show]

    end
  end
end
