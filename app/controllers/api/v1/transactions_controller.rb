class Api::V1::TransactionsController < ApplicationController
  respond_to :json

  def index
    respond_with Transaction.all
  end

  def show
    respond_with Transaction.find_by(id: params[:id])
  end

  def find
    respond_with Transaction.find_by_attribute(params.keys[0], params.values[0])
  end

  def find_all
    respond_with Transaction.find_all_by_attribute(params.keys[0], params.values[0])
  end

  def random
    respond_with Transaction.offset(rand(Transaction.count)).first
  end

  def invoice
    respond_with Transaction.find(params[:id]).invoice
  end
end
