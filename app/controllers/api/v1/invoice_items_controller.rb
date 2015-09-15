class Api::V1::InvoiceItemsController < ApplicationController
  respond_to :json

  def show
    respond_with InvoiceItem.find_by(id: params[:id])
  end

  def find
    respond_with InvoiceItem.find_by_attribute(params.keys[0], params.values[0])
  end

  def find_all
    respond_with InvoiceItem.find_all_by_attribute(params.keys[0], params.values[0])
  end

  def random
    respond_with InvoiceItem.offset(rand(InvoiceItem.count)).first
  end
end
