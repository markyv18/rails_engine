class Api::V1::MerchantsController < ApplicationController

  def index
    render json: Merchant.all
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: merchant
  end

  # def revenue
  #   render json: Merchant.find(params[:id])
  # end

  private

  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
