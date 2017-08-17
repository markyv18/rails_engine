class Api::V1::Items::InvoiceItemsController < ApplicationController
  def show
    item = Item.find(params['id'])
    render json: item.invoice_items
  end
end
