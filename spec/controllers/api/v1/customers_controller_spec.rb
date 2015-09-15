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
end
