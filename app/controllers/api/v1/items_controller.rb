class Api::V1::ItemsController < ApplicationController
  respond_to :json

  def show
    respond_with Item.find_by(id: params[:id])
  end

  def find
    respond_with Item.find_by_attribute(params.keys[0], params.values[0])
  end

  def find_all
    respond_with Item.find_all_by_attribute(params.keys[0], params.values[0])
  end

  def random
    respond_with Item.offset(rand(Item.count)).first
  end
end
