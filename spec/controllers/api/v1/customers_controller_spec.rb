require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do
  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      customer  = Customer.create(first_name: 'Sebastian',
                                 last_name:   'Abondano')
      customer_2 = Customer.create(first_name: 'Louis',
                                   last_name:  'Abondano')

      get :index, format: :json
      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(body.count).to eq(2)
      expect(body.first[:first_name]).to eq('Sebastian')
      expect(body.last[:first_name]).to eq('Louis')
    end
  end
  describe 'GET #show' do
    it 'responds successfully with an HTTP 200 status code' do
      customer = Customer.create(first_name: 'Sebastian',
                                 last_name:  'Abondano')
      get :show, format: :json, id: customer.id

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders a JSON representation of the appropriate record' do
      customer = Customer.create(first_name: 'Sebastian',
                                 last_name:  'Abondano')

      get :show, format: :json, id: customer.id
      body = JSON.parse(response.body)

      expect(body.count).to eq(5)
      expect(body['id']).to eq(customer.id)
      expect(body['first_name']).to eq('Sebastian')
      expect(body['last_name']).to eq('Abondano')
      expect(Time.zone.parse(body['created_at']).to_s).to eq(customer.created_at.to_s)
      expect(Time.zone.parse(body['updated_at']).to_s).to eq(customer.updated_at.to_s)
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

      get :find, format: :json, first_name: customer.first_name

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders a JSON representation of the appropriate record' do
      customer = Customer.create(first_name: 'Sebastian',
                                 last_name:  'Abondano')

      get :find, format: :json, first_name: customer.first_name
      body = JSON.parse(response.body)

      expect(body['id']).to eq(customer.id)
      expect(body['first_name']).to eq('Sebastian')
      expect(body['last_name']).to eq('Abondano')
    end

    it 'is case insensitive' do
      customer = Customer.create(first_name: 'Sebastian',
                                 last_name:  'Abondano')

      get :find, format: :json, first_name: 'sebastian'
      body = JSON.parse(response.body)

      expect(body['id']).to eq(customer.id)
      expect(body['first_name']).to eq('Sebastian')
      expect(body['last_name']).to eq('Abondano')
    end

    it 'finds by id' do
      customer = Customer.create(first_name: 'Sebastian',
                                 last_name:  'Abondano')

      get :find, format: :json, id: customer.id
      body = JSON.parse(response.body)

      expect(body['id']).to eq(customer.id)
      expect(body['first_name']).to eq('Sebastian')
      expect(body['last_name']).to eq('Abondano')
    end
  end

  describe 'GET #find_all' do
    it 'responds successfully with an HTTP 200 status code' do
      customer = Customer.create(first_name: 'Sebastian',
                                 last_name:  'Abondano')

      get :find_all, format: :json, first_name: customer.first_name

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders a JSON representation of the appropriate records' do
      customer = Customer.create(first_name: 'Sebastian',
                                 last_name:  'Abondano')
      Customer.create(first_name: 'Louis',
                      last_name:  'Abondano')

      get :find_all, format: :json, last_name: customer.last_name
      body = JSON.parse(response.body)

      expect(body.count).to eq(2)
      expect(body.first['id']).to eq(customer.id)
      expect(body.first['first_name']).to eq('Sebastian')
      expect(body.first['last_name']).to eq('Abondano')
    end

    it 'is case insensitive' do
      customer = Customer.create(first_name: 'Sebastian',
                                 last_name:  'Abondano')
      Customer.create(first_name: 'Louis',
                      last_name:  'Abondano')

      get :find_all, format: :json, last_name: 'abondano'
      body = JSON.parse(response.body)

      expect(body.count).to eq(2)
      expect(body.first['id']).to eq(customer.id)
      expect(body.first['first_name']).to eq('Sebastian')
      expect(body.first['last_name']).to eq('Abondano')
    end

    it 'finds by id' do
      customer = Customer.create(first_name: 'Sebastian',
                                 last_name:  'Abondano')
      Customer.create(first_name: 'Louis',
                      last_name:  'Abondano')

      get :find_all, format: :json, id: customer.id
      body = JSON.parse(response.body)

      expect(body.count).to eq(1)
      expect(body.first['id']).to eq(customer.id)
      expect(body.first['first_name']).to eq('Sebastian')
      expect(body.first['last_name']).to eq('Abondano')
    end
  end

  describe 'GET #random' do
    it 'responds successfully with an HTTP 200 status code' do
      customer = Customer.create(first_name: 'Sebastian',
                                 last_name:  'Abondano')

      get :random, format: :json

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders a JSON representation of the appropriate records' do
      customer = Customer.create(first_name: 'Sebastian',
                                 last_name:  'Abondano')
      Customer.create(first_name: 'Louis',
                      last_name:  'Abondano')

      results = []
      10.times do 
        get :random, format: :json
        body = JSON.parse(response.body, symbolize_names: true)
        results << body[:id] 
      end

      expect(results.uniq.count).not_to eq(1)
    end
  end

  describe 'GET #invoices' do
    it 'responds successfully with an HTTP 200 status code' do
      customer    = Customer.create(first_name: 'Sebastian',
                                    last_name:  'Abondano')
      merchant    = Merchant.create(name: 'Toys R Us')
      invoice     = Invoice.create(customer_id: customer.id,
                                   merchant_id: merchant.id,
                                   status:      'shipped')
      Invoice.create(customer_id: customer.id,
                     merchant_id: merchant.id,
                     status:      'ordered')

      get :invoices, format: :json, id: customer.id
      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(body.count).to eq(2)
      expect(body.first[:status]).to eq('shipped')
      expect(body.last[:status]).to eq('ordered')
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
                                       result:             'failed')
      Transaction.create(invoice_id:         invoice.id,
                         credit_card_number: '4654405418249632',
                         result:             'success')

      get :transactions, format: :json, id: customer.id
      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(body.count).to eq(2)
      expect(body.first[:id]).to eq(transaction.id)
      expect(body.first[:result]).to eq(transaction.result)
    end
  end
end
