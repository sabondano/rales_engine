class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    Merchant.find(invoices
                    .paid
                    .group(:merchant_id)
                    .count.sort_by(&:last)
                    .reverse
                    .first
                    .first)
  end
end
