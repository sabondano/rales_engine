class Item < ActiveRecord::Base
  belongs_to :merchant

  include Finders
end
