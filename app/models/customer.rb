class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :merchants, through: :invoices
  has_many :items, through: :invoice_items

  def favorite_merchant(limit = 1)
    merchants.joins(:transactions)
    .merge(Transaction.successful)
    .group('id')
    .order('count(transactions) desc')
    .first
  end

  def self.random
    order("RANDOM()").first
  end

end
