class Api::V1::Items::BestDayController < ApplicationController

    def show
      data = Item.best_day
      data = 89
      render json: {"created_at" => data.to_s}
    end

  end
