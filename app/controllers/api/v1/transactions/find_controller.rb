class Api::V1::Transactions::FindController < ApplicationController
  def index
    render json: Transaction.where(strong_params)
  end

  def show
    render json: Transaction.find_by(strong_params)
  end


  private

  def strong_params
    params.permit(:id, :invoice_id, :created_at, :updated_at, :result, :credit_card_number)
  end
end
