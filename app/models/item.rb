class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(quantity)
    ids_of_top_selling_items_by_revenue(quantity).map { |id| Item.find(id) }
  end

  def self.ids_of_top_selling_items_by_revenue(quantity)
    group_paid_invoices_by_item.sum('quantity * invoice_items.unit_price')
      .sort_by(&:last)
      .reverse
      .first(quantity)
      .map(&:first)
  end

  def self.group_paid_invoices_by_item
    Invoice.paid.joins(:items).group(:item_id)
  end

  def self.most_items(quantity)
    ids_of_top_selling_items_by_units(quantity).map { |id| Item.find(id) }
  end

  def self.ids_of_top_selling_items_by_units(quantity)
    group_paid_invoices_by_item.sum('quantity')
      .sort_by(&:last)
      .reverse
      .first(quantity)
      .map(&:first)
  end

  def best_day
    day = invoices.paid
      .group('invoices.created_at')
      .sum('quantity * unit_price')
      .sort_by(&:last)
      .reverse
      .first[0]
    { best_day: day }
  end
end
