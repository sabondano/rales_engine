require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do
  describe 'GET #index' do
    it 'renders a JSON representation of the appropriate record' do
      merchant = Merchant.create(name: 'Toys R Us')
      item = Item.create(name: 'Ball',
                         description: 'This is the description.',
                         unit_price: '12',
                         merchant_id: merchant.id)
      Item.create(name: 'Rocket',
                  description: 'This is the description.',
                  unit_price: '18',
                  merchant_id: merchant.id)

      get :index, format: :json
      body = JSON.parse(response.body)

      expect(body.count).to eq(2)
      expect(body.first.count).to eq(7)
      expect(body.first['id']).to eq(item.id)
      expect(body.first['name']).to eq('Ball')
      expect(body.first['description']).to eq('This is the description.')
      expect(body.first['unit_price']).to eq('12.0')
    end
  end

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

    describe 'GET #find_all' do
      it 'responds successfully with an HTTP 200 status code' do
        merchant = Merchant.create(name: 'Toys R Us')
        item = Item.create(name: 'Ball',
                           description: 'This is the description.',
                           unit_price: '12',
                           merchant_id: merchant.id)

        get :find_all, format: :json, name: item.name

        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it 'renders a JSON representation of the appropriate record' do
        merchant = Merchant.create(name: 'Toys R Us')
        item = Item.create(name: 'Ball',
                           description: 'This is the description.',
                           unit_price: '12',
                           merchant_id: merchant.id)
        Item.create(name: 'Rocket',
                    description: 'This is the description.',
                    unit_price: '18',
                    merchant_id: merchant.id)

        get :find_all, format: :json, description: 'This is the description.'
        body = JSON.parse(response.body)

        expect(body.count).to eq(2)
        expect(body.first.count).to eq(7)
        expect(body.first['id']).to eq(item.id)
        expect(body.first['name']).to eq('Ball')
        expect(body.first['description']).to eq('This is the description.')
        expect(body.first['unit_price']).to eq('12.0')
        expect(Time.zone.parse(body.first['created_at']).to_s).to eq(item.created_at.to_s)
        expect(Time.zone.parse(body.first['updated_at']).to_s).to eq(item.updated_at.to_s)
      end

      it 'finds by id' do
        merchant = Merchant.create(name: 'Toys R Us')
        item = Item.create(name: 'Ball',
                           description: 'This is the description.',
                           unit_price: '12',
                           merchant_id: merchant.id)

        get :find_all, format: :json, id: item.id
        body = JSON.parse(response.body)

        expect(body.first.count).to eq(7)
        expect(body.first['id']).to eq(item.id)
        expect(body.first['name']).to eq('Ball')
        expect(body.first['description']).to eq('This is the description.')
        expect(body.first['unit_price']).to eq('12.0')
        expect(Time.zone.parse(body.first['created_at']).to_s).to eq(item.created_at.to_s)
        expect(Time.zone.parse(body.first['updated_at']).to_s).to eq(item.updated_at.to_s)
      end
    end

    describe 'GET #random' do
      it 'responds successfully with an HTTP 200 status code' do
        merchant = Merchant.create(name: 'Toys R Us')
        item = Item.create(name: 'Ball',
                           description: 'This is the description.',
                           unit_price: '12',
                           merchant_id: merchant.id)
        Item.create(name: 'Rocket',
                    description: 'This is the description.',
                    unit_price: '18',
                    merchant_id: merchant.id)

        get :random, format: :json

        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it 'renders a JSON representation of the appropriate records' do
        merchant = Merchant.create(name: 'Toys R Us')
        item = Item.create(name: 'Ball',
                           description: 'This is the description.',
                           unit_price: '12',
                           merchant_id: merchant.id)
        Item.create(name: 'Rocket',
                    description: 'This is the description.',
                    unit_price: '18',
                    merchant_id: merchant.id)

        results = []
        10.times do 
          get :random, format: :json
          body = JSON.parse(response.body, symbolize_names: true)
          results << body[:id] 
        end

        expect(results.uniq.count).not_to eq(1)

        get :random, format: :json
        body = JSON.parse(response.body)

        expect(body.count).to eq(7)
        expect(body['id'].class).to eq(Fixnum)
        expect(body['name'].class).to eq(String)
        expect(body['description'].class).to eq(String)
        expect(body['unit_price'].class).to eq(String)
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

        get :invoice_items, format: :json, id: item.id
        body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(body.count).to eq(2)
        expect(body.first[:id]).to eq(invoice_item.id)
        expect(body.first[:quantity]).to eq(invoice_item.quantity)
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

        get :merchant, format: :json, id: item.id
        body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(body[:name]).to eq(merchant.name)
      end
    end
  end
