class Api::V1::MerchantsController < ApplicationController

  def index
    render json: Merchant.all
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: merchant
  end

  def create
    render json: Merchant.create(merchant_params)
  end

  def update
    render json: Merchant.update(merchant_params)
  end

  def destroy
    render json: Merchant.destroy(params[:id])
  end

  def revenue
    render json: Merchant.find(params[:id])
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
