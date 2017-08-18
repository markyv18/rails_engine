class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices

  def self.random
    order("RANDOM()").first
  end


    def self.total_merchant_revenue(id)
      self.find_by_sql("SELECT merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue
                        FROM merchants
                        INNER JOIN invoices ON merchants.id = invoices.merchant_id
                        INNER JOIN transactions ON transactions.invoice_id = invoices.id
                        INNER JOIN invoice_items ON invoices.id = invoice_items.invoice_id
                        WHERE merchants.id = #{id}
                        AND transactions.result = 'success'
                        GROUP BY merchants.id
")
    end

    def self.favorite_customer(customer_id)
      self.find_by_sql("SELECT merchants.*
                        FROM customers
                        INNER JOIN invoices ON invoices.customer_id = customers.id
                        INNER JOIN merchants ON merchants.id = invoices.merchant_id
                        WHERE customers.id = #{customer_id}
                        GROUP BY merchants.id
                        ORDER BY count(merchants.id) DESC
                        LIMIT 1
      ")
    end

end
