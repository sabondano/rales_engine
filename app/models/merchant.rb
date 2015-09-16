class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  include Finders

  def self.most_revenue(quantity)
    all.sort_by(&:revenue).reverse.first(quantity)
  end

  def revenue
    invoices.paid.joins(:invoice_items).sum('unit_price * quantity')
  end
end
