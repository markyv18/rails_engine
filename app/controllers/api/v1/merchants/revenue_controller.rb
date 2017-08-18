class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    render json: Merchant.total_merchant_revenue(params[:id])
  end
end
