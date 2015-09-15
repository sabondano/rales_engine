class Api::V1::InvoiceItemsController < ApplicationController
  respond_to :json

  def show
    respond_with InvoiceItem.find_by(id: params[:id])
  end

  def find
    attribute, attribute_value = params.keys[0], params.values[0]

    respond_with InvoiceItem.where(attribute => attribute_value).first
  end

  def find_all
    attribute, attribute_value = params.keys[0], params.values[0]

    respond_with InvoiceItem.where(attribute => attribute_value)
  end
end
