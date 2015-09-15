require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :controller do
  describe 'GET #show' do
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


      get :show, format: :json, id: transaction.id

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
      transaction = Transaction.create(invoice_id:         invoice.id,
                                       credit_card_number: '4654405418249632',
                                       result:             'success')

      get :show, format: :json, id: transaction.id
      body = JSON.parse(response.body)

      expect(body.count).to eq(7)
      expect(body['id']).to eq(transaction.id)
      expect(body['invoice_id']).to eq(invoice.id)
      expect(body['credit_card_number']).to eq('4654405418249632')
      expect(body['result']).to eq('success')
      expect(Time.zone.parse(body['created_at']).to_s).to eq(transaction.created_at.to_s)
      expect(Time.zone.parse(body['updated_at']).to_s).to eq(transaction.updated_at.to_s)
    end


    it 'renders null if the record is not found' do
      get :show, format: :json, id: 1000

      expect(response.body).to eq('null')
    end
  end
end
