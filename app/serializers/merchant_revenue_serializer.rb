class MerchantRevenueSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :created_at,
             :updated_at,
             :revenue
end
