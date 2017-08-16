class Merchant < ApplicationRecord
  has_many :items

  def revenue
    self.items.sum(:unit_price)
  end

  def self.random_merchant
    self.all.select(:id).sample
  end

  def self.random
    self.find(random_merchant)
  end
end
