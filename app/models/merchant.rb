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
    Customer.find(paid_invoice_count_per_customer_id
      .sort_by { |id_and_count| [id_and_count[1], id_and_count[0]] }.last[0])
  end

  def customers_with_pending_invoices
    invoices.failed.map { |invoice| invoice.customer }.uniq
  end

  private

  def paid_invoices
    invoices.paid
  end

  def paid_invoice_count_per_customer_id
    paid_invoices.group(:customer_id).count
  end
end
