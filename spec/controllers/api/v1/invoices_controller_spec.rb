require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :controller do
  describe 'GET #show' do
    it 'responds successfully with an HTTP 200 status code' do
      customer = Customer.create(first_name: 'Sebastian',
                                 last_name:  'Abondano')
      merchant = Merchant.create(name: 'Toys R Us')
      invoice  = Invoice.create(customer_id: customer.id,
                                merchant_id: merchant.id,
                                status: 'shipped')

      get :show, format: :json, id: invoice.id

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders a JSON representation of the appropriate record' do
      customer = Customer.create(first_name: 'Sebastian',
                                 last_name:  'Abondano')
      merchant = Merchant.create(name: 'Toys R Us')
      invoice  = Invoice.create(customer_id: customer.id,
                                merchant_id: merchant.id,
                                status: 'shipped')

      get :show, format: :json, id: invoice.id
      body = JSON.parse(response.body)

      expect(body.count).to eq(6)
      expect(body['id']).to eq(invoice.id)
      expect(body['customer_id']).to eq(customer.id)
      expect(body['merchant_id']).to eq(merchant.id)
      expect(body['status']).to eq('shipped')
      expect(Time.zone.parse(body['created_at']).to_s).to eq(invoice.created_at.to_s)
      expect(Time.zone.parse(body['updated_at']).to_s).to eq(invoice.updated_at.to_s)
    end


    it 'renders null if the record is not found' do
      get :show, format: :json, id: 1000

      expect(response.body).to eq('null')
    end
  end

  describe 'GET #find' do
    it 'responds successfully with an HTTP 200 status code' do
      customer = Customer.create(first_name: 'Sebastian',
                                 last_name:  'Abondano')
      merchant = Merchant.create(name: 'Toys R Us')
      invoice  = Invoice.create(customer_id: customer.id,
                                merchant_id: merchant.id,
                                status: 'shipped')

      get :find, format: :json, id: invoice.id

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end


    it 'renders a JSON representation of the appropriate record' do
      customer = Customer.create(first_name: 'Sebastian',
                                 last_name:  'Abondano')
      merchant = Merchant.create(name: 'Toys R Us')
      invoice  = Invoice.create(customer_id: customer.id,
                                merchant_id: merchant.id,
                                status: 'shipped')

      get :find, format: :json, status: 'Shipped'
      body = JSON.parse(response.body)

      expect(body.count).to eq(6)
      expect(body['id']).to eq(invoice.id)
      expect(body['customer_id']).to eq(customer.id)
      expect(body['merchant_id']).to eq(merchant.id)
      expect(body['status']).to eq('shipped')
      expect(Time.zone.parse(body['created_at']).to_s).to eq(invoice.created_at.to_s)
      expect(Time.zone.parse(body['updated_at']).to_s).to eq(invoice.updated_at.to_s)

    end
  end

  describe 'GET #find_all' do
    it 'responds successfully with an HTTP 200 status code' do
      customer = Customer.create(first_name: 'Sebastian',
                                 last_name:  'Abondano')
      merchant = Merchant.create(name: 'Toys R Us')
      invoice  = Invoice.create(customer_id: customer.id,
                                merchant_id: merchant.id,
                                status: 'shipped')

      get :find_all, format: :json, id: invoice.id

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end


    it 'renders a JSON representation of the appropriate record' do
      customer = Customer.create(first_name: 'Sebastian',
                                 last_name:  'Abondano')
      merchant = Merchant.create(name: 'Toys R Us')
      invoice  = Invoice.create(customer_id: customer.id,
                                merchant_id: merchant.id,
                                status: 'shipped')
      Invoice.create(customer_id: customer.id,
                     merchant_id: merchant.id,
                     status: 'shipped')

      get :find_all, format: :json, status: 'Shipped'
      body = JSON.parse(response.body)

      expect(body.count).to eq(2)
      expect(body.first.count).to eq(6)
      expect(body.first['id']).to eq(invoice.id)
      expect(body.first['customer_id']).to eq(customer.id)
      expect(body.first['merchant_id']).to eq(merchant.id)
      expect(body.first['status']).to eq('shipped')
      expect(Time.zone.parse(body.first['created_at']).to_s).to eq(invoice.created_at.to_s)
      expect(Time.zone.parse(body.first['updated_at']).to_s).to eq(invoice.updated_at.to_s)

    end
  end

  describe 'GET #random' do
    it 'responds successfully with an HTTP 200 status code' do
      customer = Customer.create(first_name: 'Sebastian',
                                 last_name:  'Abondano')
      merchant = Merchant.create(name: 'Toys R Us')
      invoice  = Invoice.create(customer_id: customer.id,
                                merchant_id: merchant.id,
                                status: 'shipped')
      Invoice.create(customer_id: customer.id,
                     merchant_id: merchant.id,
                     status: 'shipped')

      get :random, format: :json

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders a JSON representation of the appropriate records' do
      customer = Customer.create(first_name: 'Sebastian',
                                 last_name:  'Abondano')
      merchant = Merchant.create(name: 'Toys R Us')
      invoice  = Invoice.create(customer_id: customer.id,
                                merchant_id: merchant.id,
                                status: 'shipped')
      Invoice.create(customer_id: customer.id,
                     merchant_id: merchant.id,
                     status: 'shipped')

      results = []
      10.times do 
        get :random, format: :json
        body = JSON.parse(response.body, symbolize_names: true)
        results << body[:id] 
      end

      expect(results.uniq.count).not_to eq(1)

      get :random, format: :json
      body = JSON.parse(response.body)

      expect(body.count).to eq(6)
      expect(body['id'].class).to eq(Fixnum)
      expect(body['customer_id'].class).to eq(Fixnum)
      expect(body['merchant_id'].class).to eq(Fixnum)
      expect(body['status']).to eq('shipped')
    end
  end

  describe 'GET #transactions' do
    it 'responds successfully with an HTTP 200 status code' do
      customer    = Customer.create(first_name: 'Sebastian',
                                    last_name:  'Abondano')
      merchant    = Merchant.create(name: 'Toys R Us')
      invoice     = Invoice.create(customer_id: customer.id,
                                   merchant_id: merchant.id,
                                   status:      'shipped')
      transaction = Transaction.create(invoice_id:         invoice.id,
                                       credit_card_number: '4654405418249632',
                                       result:             'success')
      Transaction.create(invoice_id:         invoice.id,
                         credit_card_number: '4654405418249632',
                         result:             'denied')

      get :transactions, format: :json, id: invoice.id
      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(body.count).to eq(2)
      expect(body.first[:id]).to eq(transaction.id)
      expect(body.first[:result]).to eq('success')
    end
  end 

  describe 'GET #invoice_items' do
    it 'responds successfully with an HTTP 200 status code' do
      customer    = Customer.create(first_name: 'Sebastian',
                                    last_name:  'Abondano')
      merchant    = Merchant.create(name: 'Toys R Us')
      invoice     = Invoice.create(customer_id: customer.id,
                                   merchant_id: merchant.id,
                                   status:      'shipped')
      item = Item.create(name:        'Ball',
                         description: 'This is the description.',
                         unit_price:  '12',
                         merchant_id: 1)
      invoice_item = InvoiceItem.create(item_id:    item.id,
                                        invoice_id: invoice.id,
                                        quantity:   '5',
                                        unit_price: '12')
      InvoiceItem.create(item_id:    item.id,
                         invoice_id: invoice.id,
                         quantity:   '1',
                         unit_price: '12')

      get :invoice_items, format: :json, id: invoice.id
      body = JSON.parse(response.body, symbolize_name: true)

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(body.count).to eq(2)
      expect(body.first.count).to eq(7)
      expect(body.first['id']).to eq(invoice_item.id)
      expect(body.first['item_id']).to eq(item.id)
      expect(body.first['invoice_id']).to eq(invoice.id)
      expect(body.first['quantity']).to eq(5)
      expect(body.first['unit_price']).to eq('12.0')
    end
  end

  describe 'GET #items' do
    it 'responds successfully with an HTTP 200 status code' do
      customer    = Customer.create(first_name: 'Sebastian',
                                    last_name:  'Abondano')
      merchant    = Merchant.create(name: 'Toys R Us')
      invoice     = Invoice.create(customer_id: customer.id,
                                   merchant_id: merchant.id,
                                   status:      'shipped')
      item = Item.create(name:        'Ball',
                         description: 'This is the description.',
                         unit_price:  '12',
                         merchant_id: 1)
      item_2 = Item.create(name: 'Rocket',
                           description: 'This is the description.',
                           unit_price: '18',
                           merchant_id: merchant.id)
      invoice_item = InvoiceItem.create(item_id:    item.id,
                                        invoice_id: invoice.id,
                                        quantity:   '5',
                                        unit_price: '12')
      InvoiceItem.create(item_id:    item_2.id,
                         invoice_id: invoice.id,
                         quantity:   '1',
                         unit_price: '12')

      get :items, format: :json, id: invoice.id
      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(body.count).to eq(2)
      expect(body.first[:name]).to eq('Ball')
    end
  end

  describe 'GET #customer' do
    it 'responds successfully with an HTTP 200 status code' do
      customer    = Customer.create(first_name: 'Sebastian',
                                    last_name:  'Abondano')
      merchant    = Merchant.create(name: 'Toys R Us')
      invoice     = Invoice.create(customer_id: customer.id,
                                   merchant_id: merchant.id,
                                   status:      'shipped')

      get :customer, format: :json, id: invoice.id
      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(body[:first_name]).to eq('Sebastian')
      expect(body[:last_name]).to eq('Abondano')
    end
  end

  describe 'GET #merchant' do
    it 'responds successfully with an HTTP 200 status code' do
      customer    = Customer.create(first_name: 'Sebastian',
                                    last_name:  'Abondano')
      merchant    = Merchant.create(name: 'Toys R Us')
      invoice     = Invoice.create(customer_id: customer.id,
                                   merchant_id: merchant.id,
                                   status:      'shipped')

      get :merchant, format: :json, id: invoice.id
      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(body[:name]).to eq('Toys R Us')
    end
  end
end
