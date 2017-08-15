require 'CSV'
# Merchant.destroy
# Customer.destroy_all
# Transaction.destroy_all
# Item.destroy_all
# InvoiceItem.destroy_all
# Invoice.destroy_all

namespace :db do
  namespace :import do
    desc "import all csvs"
    task import_all: [:import_merchants,
                      :import_customers,
                      :import_invoices,
                      :import_transactions,
                      :import_items,
                      :import_invoice_items
                    ]

    desc "import merchants from csv"
    task import_merchants: :environment do
      CSV.foreach('db/csv/merchants.csv', headers: true) do |row|
        Merchant.create!(row.to_hash)
      end
      puts "Merchants Complete"
    end

    desc "import customers from csv"
    task import_customers: :environment do
      CSV.foreach('db/csv/customers.csv', headers: true) do |row|
        Customer.create!(row.to_hash)
      end
      puts "Customers Complete"
    end

    desc "import invoices from csv"
    task import_invoices: :environment do
      CSV.foreach('db/csv/invoices.csv', headers: true, header_converters: :symbol) do |row|
        Invoice.create!(
                        customer_id: row[:customer_id],
                        merchant_id: row[:merchant_id],
                        status: row[:status],
                        created_at: row[:created_at],
                        updated_at: row[:updated_at]
                        )
      end
      puts "Invoices Complete"
    end
    #
    desc "import transactions from csv"
    task import_transactions: :environment do
      CSV.foreach('db/csv/transactions.csv', headers: true, header_converters: :symbol) do |row|
        Transaction.create!(
                        invoice_id: row[:invoice_id],
                        credit_card_num: row[:credit_card_num],
                        credit_card_expiration_date: row[:credit_card_expiration_date],
                        result: row[:result],
                        created_at: row[:created_at],
                        updated_at: row[:updated_at]
                        )
      end
      puts "Transactions Complete"
    end

    desc "import items from csv"
    task import_items: :environment do
      CSV.foreach('db/csv/items.csv', headers: true, header_converters: :symbol) do |row|
        Item.create!(
                        name: row[:name],
                        description: row[:description],
                        unit_price: row[:unit_price],
                        merchant_id: row[:merchant_id],
                        created_at: row[:created_at],
                        updated_at: row[:updated_at]
                        )
      end
      puts "Items Complete"
    end

    desc "import invoice items from csv"
    task import_invoice_items: :environment do
      CSV.foreach('db/csv/invoice_items.csv', headers: true, header_converters: :symbol) do |row|
        InvoiceItem.create!(
                        item_id: row[:item_id],
                        invoice_id: row[:invoice_id],
                        quantity: row[:quantity],
                        unit_price: row[:unit_price],
                        created_at: row[:created_at],
                        updated_at: row[:updated_at]
                        )
      end
      puts "Invoice Items Complete"
    end
  end
end
