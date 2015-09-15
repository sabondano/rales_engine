require 'rails_helper'

RSpec.describe Api::V1::MerchantsController, type: :controller do
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

    it 'is case insensitive' do
      merchant = Merchant.create(name: 'Toys R Us')
      
      get :find, format: :json, name: 'toys r us'
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
end
