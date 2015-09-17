class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

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

  def revenue_for_date(date)
    invoices.paid.where(created_at: date)
      .joins(:invoice_items).sum('unit_price * quantity')
  end

  def favorite_customer
    id = transactions.successful
           .group(:customer_id)
           .count(:transactions)
           .sort_by(&:first).last[0]

    Customer.find_by(id: id)
  end

  def customers_with_pending_invoices
    pending_invoices = invoices - invoices.paid
    pending_invoices.map { |invoice| invoice.customer }
  end
end
