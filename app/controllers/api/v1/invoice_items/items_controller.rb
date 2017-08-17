class Api::V1::InvoiceItems::ItemsController < ApplicationController
  def show
    inv_item = InvoiceItem.find(params['id'])
    render json: inv_item.item
  end
end
