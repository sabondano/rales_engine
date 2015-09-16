class Api::V1::CustomersController < ApplicationController
  respond_to :json

  def show
    respond_with Customer.find_by(id: params[:id])
  end

  def find
    respond_with Customer.find_by_attribute(params.keys[0], params.values[0])
  end

  def find_all
    respond_with Customer.find_all_by_attribute(params.keys[0], params.values[0])
  end

  def random
    respond_with Customer.offset(rand(Customer.count)).first
  end

  def invoices
    respond_with Customer.find(params[:id]).invoices
  end

  def transactions
    respond_with Customer.find(params[:id]).transactions
  end
end
