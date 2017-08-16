class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.random_merchant
    self.all.select(:id).sample
  end

  def self.random
    self.find(random_merchant)
  end
end
