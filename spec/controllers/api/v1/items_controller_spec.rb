require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do
  describe 'GET #show' do
    it 'responds successfully with an HTTP 200 status code' do
      merchant = Merchant.create(name: 'Toys R Us')
      item = Item.create(name: 'Ball',
                         description: 'This is the description.',
                         unit_price: '12',
                         merchant_id: merchant.id)
                          
      get :show, format: :json, id: item.id

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders a JSON representation of the appropriate record' do
      merchant = Merchant.create(name: 'Toys R Us')
      item = Item.create(name: 'Ball',
                         description: 'This is the description.',
                         unit_price: '12',
                         merchant_id: merchant.id)

      get :show, format: :json, id: item.id
      body = JSON.parse(response.body)

      expect(body.count).to eq(7)
      expect(body['id']).to eq(item.id)
      expect(body['name']).to eq('Ball')
      expect(body['description']).to eq('This is the description.')
      expect(body['unit_price']).to eq('12.0')
      expect(Time.zone.parse(body['created_at']).to_s).to eq(item.created_at.to_s)
      expect(Time.zone.parse(body['updated_at']).to_s).to eq(item.updated_at.to_s)
    end


    it 'renders null if the record is not found' do
      get :show, format: :json, id: 1000
      
      expect(response.body).to eq('null')
    end
  end

  describe 'GET #find' do
    it 'responds successfully with an HTTP 200 status code' do
      merchant = Merchant.create(name: 'Toys R Us')
      item = Item.create(name: 'Ball',
                         description: 'This is the description.',
                         unit_price: '12',
                         merchant_id: merchant.id)

      get :find, format: :json, name: item.name

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders a JSON representation of the appropriate record' do
      merchant = Merchant.create(name: 'Toys R Us')
      item = Item.create(name: 'Ball',
                         description: 'This is the description.',
                         unit_price: '12',
                         merchant_id: merchant.id)

      get :find, format: :json, name: item.name
      body = JSON.parse(response.body)

      expect(body.count).to eq(7)
      expect(body['id']).to eq(item.id)
      expect(body['name']).to eq('Ball')
      expect(body['description']).to eq('This is the description.')
      expect(body['unit_price']).to eq('12.0')
      expect(Time.zone.parse(body['created_at']).to_s).to eq(item.created_at.to_s)
      expect(Time.zone.parse(body['updated_at']).to_s).to eq(item.updated_at.to_s)
    end

    it 'finds by id' do
      merchant = Merchant.create(name: 'Toys R Us')
      item = Item.create(name: 'Ball',
                         description: 'This is the description.',
                         unit_price: '12',
                         merchant_id: merchant.id)

      get :find, format: :json, id: item.id
      body = JSON.parse(response.body)

      expect(body.count).to eq(7)
      expect(body['id']).to eq(item.id)
      expect(body['name']).to eq('Ball')
      expect(body['description']).to eq('This is the description.')
      expect(body['unit_price']).to eq('12.0')
      expect(Time.zone.parse(body['created_at']).to_s).to eq(item.created_at.to_s)
      expect(Time.zone.parse(body['updated_at']).to_s).to eq(item.updated_at.to_s)
    end
  end
end
