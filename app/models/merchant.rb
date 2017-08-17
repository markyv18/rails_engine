class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices

  def self.random_merchant
    self.all.select(:id).sample
  end

  def self.random
    self.find(random_merchant)
  end
end
