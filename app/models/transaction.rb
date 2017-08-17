class Transaction < ApplicationRecord
  belongs_to :invoice

  def self.random_transaction
    self.all.select(:id).sample
  end

  def self.random
    self.find(random_transaction)
  end

end
