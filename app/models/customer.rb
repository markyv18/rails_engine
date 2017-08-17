class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :merchants, through: :invoices
  has_many :items, through: :invoice_items

  def favorite_merchant
    merchants.joins(:transactions)
    .merge(Transaction.successful)
    .group('id')
    .order('count(transactions) desc')
    .first
  end

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
