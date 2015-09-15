class Api::V1::CustomersController < ApplicationController
  respond_to :json

  def show
    respond_with Customer.find_by(id: params[:id])
  end

  def find
    attribute, attribute_value = params.keys[0], params.values[0]

    if attribute_value.to_s == attribute_value.to_i.to_s
      respond_with Customer.where(attribute => attribute_value).first
    else
      respond_with Customer.where("#{attribute} ilike ?",
                                  "%#{attribute_value}%").first
    end
  end

  def find_all
    attribute, attribute_value = params.keys[0], params.values[0]

    if attribute_value.to_s == attribute_value.to_i.to_s
      respond_with Customer.where(attribute => attribute_value)
    else
      respond_with Customer.where("#{attribute} ilike ?",
                                  "%#{attribute_value}%")
    end
  end

  def random
    offset = rand(Customer.count)
    respond_with Customer.offset(offset).first
  end
end
