class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(quantity)
    ids_of_top_selling_items(quantity).map { |id| Item.find(id) }
  end

  def self.top_selling_items_ids(quantity)
    grouped_paid_invoices_by_item.sum('quantity * invoice_items.unit_price').sort_by(&:last)
      .reverse.first(quantity).map(&:first)
  end

  def self.grouped_paid_invoices_by_item
    Invoice.paid.joins(:items).group(:item_id)
  end
end
