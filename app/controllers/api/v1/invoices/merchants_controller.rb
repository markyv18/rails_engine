class Api::V1::Invoices::MerchantsController < ApplicationController
  def index
    invoice = Invoice.find(params['id'])
    render json: invoice.merchant
  end
end
