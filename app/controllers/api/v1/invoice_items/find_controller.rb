class Api::V1::InvoiceItems::FindController < ApplicationController

  def index
    render json: InvoiceItem.where(strong_params)
    end

  def show
    render json: InvoiceItem.find_by(strong_params)
  end

    private

    def strong_params
      params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
    end
  end
