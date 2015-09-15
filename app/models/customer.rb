class Customer < ActiveRecord::Base
  has_many :invoices

  include Finders
end
