require 'rails_helper'

RSpec.describe Api::V1::MerchantsController, type: :controller do
  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      merchant = Merchant.create(name: 'Toys R Us')

      get :index, format: :json
      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(body.first[:name]).to eq(merchant.name)
    end
  end

  describe 'GET #show' do
    it 'responds successfully with an HTTP 200 status code' do
      merchant = Merchant.create(name: 'Toys R Us')

      get :show, format: :json, id: merchant.id

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders a JSON representation of the appropriate record' do
      merchant = Merchant.create(name: 'Toys R Us')

      get :show, format: :json, id: merchant.id
      body = JSON.parse(response.body)

      expect(body.count).to eq(4)
      expect(body['id']).to eq(merchant.id)
      expect(body['name']).to eq('Toys R Us')
      expect(Time.zone.parse(body['created_at']).to_s).to eq(merchant.created_at.to_s)
      expect(Time.zone.parse(body['updated_at']).to_s).to eq(merchant.updated_at.to_s)
    end

    it 'renders null if the record is not found' do
      get :show, format: :json, id: 1000

      expect(response.body).to eq('null')
    end
  end

  describe 'GET #find' do
    it 'responds successfully with an HTTP 200 status code' do
      merchant = Merchant.create(name: 'Toys R Us')

      get :find, format: :json, name: merchant.name

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders a JSON representation of the appropriate record' do
      merchant = Merchant.create(name: 'Toys R Us')

      get :find, format: :json, name: merchant.name
      body = JSON.parse(response.body)

      expect(body['id']).to eq(merchant.id)
      expect(body['name']).to eq('Toys R Us')
    end

    it 'finds by id' do
      merchant = Merchant.create(name: 'Toys R Us')

      get :find, format: :json, id: merchant.id
      body = JSON.parse(response.body)

      expect(body['id']).to eq(merchant.id)
      expect(body['name']).to eq('Toys R Us')
    end

  end

  describe 'GET #find_all' do
    it 'responds successfully with an HTTP 200 status code' do
      merchant = Merchant.create(name: 'Toys R Us')

      get :find_all, format: :json, name: merchant.name

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders a JSON representation of the appropriate record' do
      merchant = Merchant.create(name: 'Toys R Us')

      get :find_all, format: :json, name: merchant.name
      body = JSON.parse(response.body)

      expect(body.class).to eq(Array)
      expect(body.first['id']).to eq(merchant.id)
      expect(body.first['name']).to eq('Toys R Us')
    end

    it 'finds by id' do
      merchant = Merchant.create(name: 'Toys R Us')

      get :find_all, format: :json, id: merchant.id
      body = JSON.parse(response.body)

      expect(body.first['id']).to eq(merchant.id)
      expect(body.first['name']).to eq('Toys R Us')
    end
  end

  describe 'GET #random' do
    it 'responds successfully with an HTTP 200 status code' do
      merchant = Merchant.create(name: 'Toys R Us')
      merchant = Merchant.create(name: 'Other')

      get :random, format: :json

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders a JSON representation of the appropriate records' do
      merchant = Merchant.create(name: 'Toys R Us')
      merchant = Merchant.create(name: 'Other')

      results = []
      10.times do 
        get :random, format: :json
        body = JSON.parse(response.body, symbolize_names: true)
        results << body[:id] 
      end

      expect(results.uniq.count).not_to eq(1)

      get :random, format: :json
      body = JSON.parse(response.body)

      expect(body['id'].class).to eq(Fixnum)
      expect(body['name'].class).to eq(String)
    end
  end

  describe 'GET #items' do
    it 'responds successfully with an HTTP 200 status code' do
      merchant = Merchant.create(name: 'Toys R Us')
      item = Item.create(name: 'Ball',
                         description: 'This is the description.',
                         unit_price: '12',
                         merchant_id: merchant.id)
      Item.create(name: 'Toy',
                  description: 'This is the description.',
                  unit_price: '12',
                  merchant_id: merchant.id)

      get :items, format: :json, id: merchant.id
      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(body.count).to eq(2)
      expect(body.first[:id]).to eq(item.id)
      expect(body.first[:name]).to eq(item.name)
    end
  end

  describe 'GET #invoices' do
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

      get :invoices, format: :json, id: merchant.id
      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(body.count).to eq(2)
      expect(body.first[:id]).to eq(invoice.id)
      expect(body.first[:status]).to eq('shipped')
    end
  end

  describe 'GET #most_revenue' do
    it 'responds successfully with an HTTP 200 status code' do
      customer      = Customer.create(first_name: 'Sebastian',
                                      last_name:  'Abondano')
      merchant      = Merchant.create(name: 'Toys R Us')
      merchant_2    = Merchant.create(name: 'Other') 
      invoice       = Invoice.create(customer_id: customer.id,
                                     merchant_id: merchant.id,
                                     status:      'shipped')
      invoice_2     = Invoice.create(customer_id: customer.id,
                                     merchant_id: merchant_2.id,
                                     status:      'shipped')
      transaction   = Transaction.create(invoice_id:         invoice.id,
                                         credit_card_number: '4654405418249632',
                                         result:             'success')
      transaction_2 = Transaction.create(invoice_id:         invoice_2.id,
                                         credit_card_number: '4654405418249632',
                                         result:             'success')
      item          = Item.create(name:        'Ball',
                                  description: 'This is the description.',
                                  unit_price:  '12',
                                  merchant_id: 1)

      invoice_item  = InvoiceItem.create(item_id:    item.id,
                                         invoice_id: invoice.id,
                                         quantity:   '1',
                                         unit_price: '12')
      InvoiceItem.create(item_id: item.id,
                         invoice_id: invoice_2.id,
                         quantity: '5',
                         unit_price: '12')

      get :most_revenue, format: :json, quantity: 2
      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(body.count).to eq(2)
      expect(body.first[:id]).to eq(merchant_2.id)
    end
  end
end
