Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      get '/merchants/most_revenue', to: 'merchants#most_revenue'

      get '/customers/:id/invoices',      to: 'customers#invoices'
      get '/customers/:id/transactions',  to: 'customers#transactions'

      get '/transactions/:id/invoice', to: 'transactions#invoice'

      get '/items/:id/invoice_items', to: 'items#invoice_items'
      get '/items/:id/merchant',      to: 'items#merchant'

      get '/invoice_items/:id/invoice',  to: 'invoice_items#invoice'
      get '/invoice_items/:id/item',     to: 'invoice_items#item'

      get '/invoices/:id/transactions',  to: 'invoices#transactions'
      get '/invoices/:id/invoice_items', to: 'invoices#invoice_items'
      get '/invoices/:id/items',         to: 'invoices#items'
      get '/invoices/:id/customer',      to: 'invoices#customer'
      get '/invoices/:id/merchant',      to: 'invoices#merchant'

      get '/merchants/:id/items',    to: 'merchants#items'
      get '/merchants/:id/invoices', to: 'merchants#invoices'

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

      get '/merchants/random',     to: 'merchants#random'
      get '/customers/random',     to: 'customers#random'
      get '/invoice_items/random', to: 'invoice_items#random'
      get '/invoices/random',      to: 'invoices#random'
      get '/items/random',         to: 'items#random'
      get '/transactions/random',  to: 'transactions#random'

      resources :customers,     only: [:show]
      resources :merchants,     only: [:show]
      resources :items,         only: [:show]
      resources :invoices,      only: [:show]
      resources :transactions,  only: [:show]
      resources :invoice_items, only: [:show]
    end
  end
end
