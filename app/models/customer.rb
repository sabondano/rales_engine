class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    Merchant.find(merchant_with_most_invoices(count_paid_invoices_grouped_by_merchant_id))
  end

  private

  def count_paid_invoices_grouped_by_merchant_id
    invoices.paid.group(:merchant_id).count
  end

  def merchant_with_most_invoices(merchant_invoice_count)
    merchant_invoice_count.sort_by { |merchant_id, count| count }.last[0]
  end
end
