class Transaction < ActiveRecord::Base
  belongs_to :invoice

  include Finders
end
