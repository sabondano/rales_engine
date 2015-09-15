require 'rails_helper'

RSpec.describe Api::V1::InvoiceItemsController, type: :controller do
  describe 'GET #show' do
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


      get :show, format: :json, id: invoice_item.id

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders a JSON representation of the appropriate record' do
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

      get :show, format: :json, id: invoice_item.id
      body = JSON.parse(response.body)

      expect(body.count).to eq(7)
      expect(body['id']).to eq(invoice_item.id)
      expect(body['item_id']).to eq(item.id)
      expect(body['invoice_id']).to eq(invoice.id)
      expect(body['quantity']).to eq(5)
      expect(body['unit_price']).to eq('12.0')
      expect(Time.zone.parse(body['created_at']).to_s).to eq(invoice_item.created_at.to_s)
      expect(Time.zone.parse(body['updated_at']).to_s).to eq(invoice_item.updated_at.to_s)
    end


    it 'renders null if the record is not found' do
      get :show, format: :json, id: 1000

      expect(response.body).to eq('null')
    end
  end

  describe 'GET #find' do
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

      get :find, format: :json, item_id: invoice_item.item_id
      
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders a JSON representation of the appropriate record' do
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

      get :find, format: :json, item_id: invoice_item.item_id
      body = JSON.parse(response.body)
      
      expect(body.count).to eq(7)
      expect(body['id']).to eq(invoice_item.id)
      expect(body['item_id']).to eq(item.id)
      expect(body['invoice_id']).to eq(invoice.id)
      expect(body['quantity']).to eq(5)
      expect(body['unit_price']).to eq('12.0')
      expect(Time.zone.parse(body['created_at']).to_s).to eq(invoice_item.created_at.to_s)
      expect(Time.zone.parse(body['updated_at']).to_s).to eq(invoice_item.updated_at.to_s)
    end
  end

  describe 'GET #find_all' do
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

      get :find_all, format: :json, item_id: invoice_item.item_id
      
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders a JSON representation of the appropriate record' do
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

      get :find_all, format: :json, item_id: invoice_item.item_id
      body = JSON.parse(response.body)

      expect(body.count).to eq(2)
      expect(body.first.count).to eq(7)
      expect(body.first['id']).to eq(invoice_item.id)
      expect(body.first['item_id']).to eq(item.id)
      expect(body.first['invoice_id']).to eq(invoice.id)
      expect(body.first['quantity']).to eq(5)
      expect(body.first['unit_price']).to eq('12.0')
      expect(Time.zone.parse(body.first['created_at']).to_s).to eq(invoice_item.created_at.to_s)
      expect(Time.zone.parse(body.first['updated_at']).to_s).to eq(invoice_item.updated_at.to_s)
    end
  end

  describe 'GET #random' do
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

      get :random, format: :json

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders a JSON representation of the appropriate records' do
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
      expect(body['item_id'].class).to eq(Fixnum)
      expect(body['invoice_id'].class).to eq(Fixnum)
      expect(body['quantity'].class).to eq(Fixnum)
      expect(body['unit_price'].class).to eq(String)
    end
  end

  describe 'GET #invoice' do
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

      get :invoice, format: :json, id: invoice_item.id
      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(body[:id]).to eq(invoice.id)
      expect(body[:customer_id]).to eq(invoice.customer_id)
      expect(body[:merchant_id]).to eq(invoice.merchant_id)
      expect(body[:status]).to eq('shipped')
    end
  end

  describe 'GET #item' do
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

      get :item, format: :json, id: invoice_item.id
      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(body[:id]).to eq(item.id)
      expect(body[:name]).to eq(item.name)
      expect(body[:description]).to eq(item.description)
      expect(body[:unit_price]).to eq('12.0')
      expect(body[:merchant_id]).to eq(item.merchant_id)
    end
  end
end
