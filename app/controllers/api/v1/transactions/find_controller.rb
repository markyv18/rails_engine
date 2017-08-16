class Api::V1::Transactions::FindController < ApplicationController
  def index
    render json: transaction
  end

  def show
    render json: transaction
  end


  private

  def transaction
    Transaction.where(strong_params)
  end

  def strong_params
    params.permit(:id, :invoice_id, :created_at, :updated_at, :result, :credit_card_number)
  end
end
