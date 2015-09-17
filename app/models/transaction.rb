class Transaction < ActiveRecord::Base
  belongs_to :invoice

  def self.successful
    where("result = 'success'") 
  end
end
