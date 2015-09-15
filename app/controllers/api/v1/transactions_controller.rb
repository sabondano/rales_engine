class Api::V1::TransactionsController < ApplicationController
  respond_to :json

  def show
    respond_with Transaction.find_by(id: params[:id])
  end

  def find
    attribute, attribute_value = params.keys[0], params.values[0]

    if attribute_value.to_s == attribute_value.to_i.to_s
      respond_with Transaction.where(attribute => attribute_value).first
    else
      respond_with Transaction.where("#{attribute} ilike ?",
                              "%#{attribute_value}%").first
    end
  end
end
