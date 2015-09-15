require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do
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

end
