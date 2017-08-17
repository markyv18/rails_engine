class Customer < ApplicationRecord
  has_many :invoices

  def name
    name = self.first_name + " " + self.last_name
  end

  def self.random_customer
    self.all.select(:id).sample
  end

  def self.random
    self.find(random_customer)
  end
end
