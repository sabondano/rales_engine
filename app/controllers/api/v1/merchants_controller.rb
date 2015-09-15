class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def show
    respond_with Merchant.find_by(id: params[:id])
  end


  def find
    attribute, attribute_value = params.keys[0], params.values[0]

    if attribute_value.to_s == attribute_value.to_i.to_s
      respond_with Merchant.where(attribute => attribute_value).first
    else
      respond_with Merchant.where("#{attribute} ilike ?",
                                  "%#{attribute_value}%").first
    end
  end
end
