class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.most_revenue(quantity)
    all.sort_by(&:revenue).reverse.first(quantity)
  end

  def revenue
    invoices.paid.joins(:invoice_items).sum('unit_price * quantity')
  end

  def self.most_items(quantity)
    all.sort_by(&:units_sold).reverse.first(quantity)
  end

  def units_sold
    invoices.paid.joins(:invoice_items).sum('quantity')
  end

  def self.total_revenue_for_date(date)
    revenue = Invoice.paid
      .where(created_at: date)
      .joins(:invoice_items)
      .sum('unit_price * quantity')
    { total_revenue: revenue }
  end
end
