class Api::V1::Merchants::FindController < ApplicationController
  def index
    render json: merchant
  end

  def show
    render json: merchant
  end


  private

  def merchant
    Merchant.where(strong_params)
  end
  
  def strong_params
    params.permit(:name, :id, :created_at, :updated_at)
  end
end
