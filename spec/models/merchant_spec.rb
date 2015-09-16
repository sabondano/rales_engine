require 'rails_helper'

describe Merchant do
  it 'returns #revenue successfully' do
    customer    = Customer.create(first_name: 'Sebastian',
                                    last_name:  'Abondano')
      merchant    = Merchant.create(name: 'Toys R Us')
      merchant_2  = Merchant.create(name: 'Other') 
      invoice     = Invoice.create(customer_id: customer.id,
                                   merchant_id: merchant.id,
                                   status:      'shipped')
      invoice_2    = Invoice.create(customer_id: customer.id,
                                    merchant_id: merchant_2.id,
                                    status:      'shipped')
      transaction = Transaction.create(invoice_id:         invoice.id,
                                       credit_card_number: '4654405418249632',
                                       result:             'success')
      transaction_2 = Transaction.create(invoice_id:         invoice_2.id,
                                         credit_card_number: '4654405418249632',
                                         result:             'success')
      item         = Item.create(name:        'Ball',
                                 description: 'This is the description.',
                                 unit_price:  '12',
                                 merchant_id: 1)

      invoice_item = InvoiceItem.create(item_id:    item.id,
                                        invoice_id: invoice.id,
                                        quantity:   '1',
                                        unit_price: '1200')
      InvoiceItem.create(item_id: item.id,
                         invoice_id: invoice_2.id,
                         quantity: '5',
                         unit_price: '1200')

      expect(merchant.revenue).to eq(12.00)
      expect(merchant_2.revenue).to eq(60.00)
  end
end
