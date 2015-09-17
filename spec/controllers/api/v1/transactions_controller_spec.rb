require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :controller do
  describe 'GET #index' do
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
      Transaction.create(invoice_id:         invoice.id,
                         credit_card_number: '4654405418249632',
                         result:             'success')

      get :index, format: :json
      body = JSON.parse(response.body)

      expect(body.count).to eq(2)
      expect(body.first.count).to eq(6)
      expect(body.first['id']).to eq(transaction.id)
      expect(body.first['invoice_id']).to eq(invoice.id)
      expect(body.first['credit_card_number']).to eq('4654405418249632')
      expect(body.first['result']).to eq('success')
    end
  end

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

        expect(body.count).to eq(6)
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


    describe 'GET #find' do
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

        get :find, format: :json, id: transaction.id

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

        get :find, format: :json, result: 'success'
        body = JSON.parse(response.body)

        expect(body.count).to eq(6)
        expect(body['id']).to eq(transaction.id)
        expect(body['invoice_id']).to eq(invoice.id)
        expect(body['credit_card_number']).to eq('4654405418249632')
        expect(body['result']).to eq('success')
        expect(Time.zone.parse(body['created_at']).to_s).to eq(transaction.created_at.to_s)
        expect(Time.zone.parse(body['updated_at']).to_s).to eq(transaction.updated_at.to_s)
      end

      it 'finds by id' do
        customer    = Customer.create(first_name: 'Sebastian',
                                      last_name:  'Abondano')
        merchant    = Merchant.create(name: 'Toys R Us')
        invoice     = Invoice.create(customer_id: customer.id,
                                     merchant_id: merchant.id,
                                     status:      'shipped')
        transaction = Transaction.create(invoice_id:         invoice.id,
                                         credit_card_number: '4654405418249632',
                                         result:             'success')

        get :find, format: :json, id: transaction.id
        body = JSON.parse(response.body)

        expect(body.count).to eq(6)
        expect(body['id']).to eq(transaction.id)
        expect(body['invoice_id']).to eq(invoice.id)
        expect(body['credit_card_number']).to eq('4654405418249632')
        expect(body['result']).to eq('success')
        expect(Time.zone.parse(body['created_at']).to_s).to eq(transaction.created_at.to_s)
        expect(Time.zone.parse(body['updated_at']).to_s).to eq(transaction.updated_at.to_s)
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
        transaction = Transaction.create(invoice_id:         invoice.id,
                                         credit_card_number: '4654405418249632',
                                         result:             'success')

        get :find_all, format: :json, id: transaction.id

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
        Transaction.create(invoice_id:         invoice.id,
                           credit_card_number: '4654405418249632',
                           result:             'success')

        get :find_all, format: :json, result: 'success'
        body = JSON.parse(response.body)

        expect(body.count).to eq(2)
        expect(body.first.count).to eq(6)
        expect(body.first['id']).to eq(transaction.id)
        expect(body.first['invoice_id']).to eq(invoice.id)
        expect(body.first['credit_card_number']).to eq('4654405418249632')
        expect(body.first['result']).to eq('success')
        expect(Time.zone.parse(body.first['created_at']).to_s).to eq(transaction.created_at.to_s)
        expect(Time.zone.parse(body.first['updated_at']).to_s).to eq(transaction.updated_at.to_s)
      end

      it 'finds by id' do
        customer    = Customer.create(first_name: 'Sebastian',
                                      last_name:  'Abondano')
        merchant    = Merchant.create(name: 'Toys R Us')
        invoice     = Invoice.create(customer_id: customer.id,
                                     merchant_id: merchant.id,
                                     status:      'shipped')
        transaction = Transaction.create(invoice_id:         invoice.id,
                                         credit_card_number: '4654405418249632',
                                         result:             'success')
        Transaction.create(invoice_id:         invoice.id,
                           credit_card_number: '4654405418249632',
                           result:             'success')

        get :find_all, format: :json, id: transaction.id
        body = JSON.parse(response.body)

        expect(body.count).to eq(1)
        expect(body.first.count).to eq(6)
        expect(body.first['id']).to eq(transaction.id)
        expect(body.first['invoice_id']).to eq(invoice.id)
        expect(body.first['credit_card_number']).to eq('4654405418249632')
        expect(body.first['result']).to eq('success')
        expect(Time.zone.parse(body.first['created_at']).to_s).to eq(transaction.created_at.to_s)
        expect(Time.zone.parse(body.first['updated_at']).to_s).to eq(transaction.updated_at.to_s)
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
        transaction = Transaction.create(invoice_id:         invoice.id,
                                         credit_card_number: '4654405418249632',
                                         result:             'success')
        Transaction.create(invoice_id:         invoice.id,
                           credit_card_number: '4654405418249632',
                           result:             'success')


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
        transaction = Transaction.create(invoice_id:         invoice.id,
                                         credit_card_number: '4654405418249632',
                                         result:             'success')
        Transaction.create(invoice_id:         invoice.id,
                           credit_card_number: '4654405418249632',
                           result:             'success')


        results = []
        10.times do 
          get :random, format: :json
          body = JSON.parse(response.body, symbolize_names: true)
          results << body[:id] 
        end

        expect(results.uniq.count).not_to eq(1)

        get :random, format: :json
        body = JSON.parse(response.body, symbolize_names: true)

        expect(body[:id].class).to eq(Fixnum)
        expect(body[:invoice_id].class).to eq(Fixnum)
        expect(body[:credit_card_number].class).to eq(String)
        expect(body[:result].class).to eq(String)
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
        transaction = Transaction.create(invoice_id:         invoice.id,
                                         credit_card_number: '4654405418249632',
                                         result:             'success')

        get :invoice, format: :json, id: transaction.id
        body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(body[:id]).to eq(invoice.id)
        expect(body[:customer_id]).to eq(invoice.customer_id)
        expect(body[:merchant_id]).to eq(invoice.merchant_id)
        expect(body[:status]).to eq(invoice.status)
      end
    end
  end
