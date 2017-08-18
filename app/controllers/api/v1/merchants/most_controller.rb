class Api::V1::Merchants::MostController < ApplicationController
  def index
    render json: Merchant.most_revenue_all(params[:quantity])
  end
end
