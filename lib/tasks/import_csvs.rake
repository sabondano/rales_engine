namespace :import_csvs do
  desc "import all of the CSVs and create records"
  task all: :environment do
    customers_data = Parser.parse('./db/csv_data/customers.csv')    
    customers_data.map { |attributes| Customer.create!(attributes.to_h) }

    merchants_data = Parser.parse('./db/csv_data/merchants.csv')    
    merchants_data.map { |attributes| Merchant.create!(attributes.to_h) }

    items_data = Parser.parse('./db/csv_data/items.csv')    
    items_data.map { |attributes| Item.create!(attributes.to_h) }

    invoices_data = Parser.parse('./db/csv_data/invoices.csv')    
    invoices_data.map { |attributes| Invoice.create!(attributes.to_h) }

    transactions_data = Parser.parse('./db/csv_data/transactions.csv')    
    transactions_data.map { |attributes| Transaction.create!(attributes.to_h) }

    invoice_items_data = Parser.parse('./db/csv_data/invoice_items.csv')    
    invoice_items_data.map { |attributes| InvoiceItem.create!(attributes.to_h) }
  end

end
