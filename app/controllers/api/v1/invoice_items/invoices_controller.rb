class Api::V1::InvoiceItems::InvoicesController < ApplicationController
  def show
    inv_items = InvoiceItem.find(params['id'])
    render json: inv_items.invoice
  end
end
