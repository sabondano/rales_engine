class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(id: params[:id])
  end

  def find
    respond_with Merchant.find_by(find_params)
  end

  def find_all
    respond_with Merchant.where(find_params)
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

  def most_revenue
    respond_with Merchant.most_revenue(params[:quantity].to_i),
      each_serializer: MerchantRevenueSerializer
  end

  def most_items
    respond_with Merchant.most_items(params[:quantity].to_i)
  end

  def revenue
    respond_with Merchant.total_revenue_for_date(find_params[:date])
  end

  def revenue_for_merchant
    merchant = Merchant.find(params[:id])
    if params[:date]
      revenue = { revenue: merchant.revenue_for_date(params[:date]) }
    else
      revenue = { revenue: merchant.revenue }
    end
      respond_with revenue
  end

  def favorite_customer
    respond_with Merchant.find(params[:id]).favorite_customer
  end

  def customers_with_pending_invoices
    respond_with Merchant.find(params[:id]).customers_with_pending_invoices
  end

  private

  def find_params
    params.permit(:id, :name, :created_at, :updated_at, :date)
  end
end
