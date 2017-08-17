class Api::V1::Merchants::FindController < ApplicationController
  def index
    render json: Merchant.where(strong_params)
  end

  def show
    render json: Merchant.find_by(strong_params)
  end


  private
  def strong_params
    params.permit(:name, :id, :created_at, :updated_at)
  end
end
