class Api::V1::Items::RevenueController < ApplicationController

    def index
      render json: Item.most_revenue(params[:quantity])
    end

    def show
      render json: Item.most_items_sold(params[:quantity]) 
    end

  end
