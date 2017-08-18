class Api::V1::Merchants::FavoriteMerchantController < ApplicationController

  def show
    render json: Merchant.favorite_customer(params[:customer_id].to_i)
  end
end
