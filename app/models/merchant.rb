class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices

  def self.random
    order("RANDOM()").first
  end

  def self.most_revenue_all(top_x)
    self.find_by_sql("SELECT m.*, SUM(unit_price * quantity) as revenue
    FROM merchants m
    INNER JOIN invoices i ON i.merchant_id = m.id
    INNER JOIN invoices invoices_merchants_join ON invoices_merchants_join.merchant_id = m.id
    INNER JOIN invoice_items ON invoice_items.invoice_id = invoices_merchants_join.id
    GROUP BY m.id
    ORDER BY revenue
    desc LIMIT #{top_x}"
    )
    # self.joins(:invoices, :invoice_items)
    #   .group(:id)
    #   .select('merchants.*, SUM(unit_price * quantity) as revenue')
    #   .order('revenue desc').limit(top_x)
  end

  def self.most_items_sold(top_x)
    self.find_by_sql("SELECT  m.*, SUM(quantity) as items_sold
    FROM merchants m
    INNER JOIN items i ON i.merchant_id = m.id
    INNER JOIN invoices inv ON inv.merchant_id = m.id
    INNER JOIN invoice_items ii ON ii.invoice_id = inv.id
    INNER JOIN transactions t ON i.id = t.invoice_id
    WHERE t.result = 'success'
    GROUP BY m.id
    ORDER BY items_sold
    desc LIMIT #{top_x};")
  end
end
