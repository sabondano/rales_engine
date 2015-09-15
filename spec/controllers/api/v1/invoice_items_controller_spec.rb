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
end
