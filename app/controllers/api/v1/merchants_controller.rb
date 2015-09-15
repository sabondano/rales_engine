class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def show
    respond_with Merchant.find_by(id: params[:id])
  end

  def find
    respond_with Merchant.find_by_attribute(params.keys[0], params.values[0])
  end

  def find_all
    respond_with Merchant.find_all_by_attribute(params.keys[0], params.values[0])
  end

  def random
    respond_with Merchant.offset(rand(Merchant.count)).first
  end

  def items
    respond_with Merchant.find(params[:id]).items
  end

  def invoices
    respond_with Merchant.find(params[:id]).invoices
  end
end
