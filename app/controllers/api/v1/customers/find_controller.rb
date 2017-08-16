class Api::V1::Customers::FindController < ApplicationController
  def index
    render json: customer
  end

  def show
    render json: customer
  end

  private

  def customer
    customer = Customer.where(strong_params)
  end

  def strong_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
end
