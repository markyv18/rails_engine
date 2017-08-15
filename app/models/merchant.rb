class Merchant < ApplicationRecord
  has_many :items
  def revenue
    self.items.sum(:unit_price)
  end

  
end
