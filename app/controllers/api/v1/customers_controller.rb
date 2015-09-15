class Api::V1::CustomersController < ApplicationController
  respond_to :json

  def show
    respond_with Customer.find_by(id: params[:id])
  end
end
