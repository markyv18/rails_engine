require 'rails_helper'

describe "Invoices relationship endpoint" do
  it "returns a collection of associated transactions" do
    invoice = create(:invoice)
    transactions = create(:transaction, invoice: invoice)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    expect(response).to be_success

    invoice_transactions = JSON.parse(response.body)

    expect(invoice_transactions.first["invoice_id"]).to eq(transactions.invoice_id)
  end

  it "returns a collection of associated invoice_items" do
    invoice = create(:invoice)
    invoice_items = create_list(:invoice_item, 5, invoice: invoice)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    invoice_invoice_items = JSON.parse(response.body)

    expect(invoice_invoice_items.count).to eq(5)

    expect(invoice_invoice_items.all? {
        |invoice_item_hash|
        InvoiceItem.find(invoice_item_hash["id"]).invoice_id == invoice.id}).to be true
  end

  it "returns a collection of associated items" do
    invoice = create(:invoice)
    items = create_list(:item, 5)
    invoice_items = items.map do |item|
        create(:invoice_item, item: item, invoice: invoice)
      end

    get "/api/v1/invoices/#{invoice.id}/items"

    the_invoices_items = JSON.parse(response.body)

    expect(the_invoices_items.count).to eq(5)
    expect(the_invoices_items.first["id"]).to eq(items.first.id)
  end

  it "returns the associated customer" do
    customer = create(:customer)
    invoice = create(:invoice, customer: customer)

    get "/api/v1/invoices/#{invoice.id}/customer"

    expect(response).to be_success

    invoice_customer = JSON.parse(response.body)

    expect(invoice_customer["id"]).to eq(invoice.customer_id)
  end

  it "returns the associated merchant" do
    merchant = create(:merchant)
    invoice = create(:invoice, merchant: merchant)

    get "/api/v1/invoices/#{invoice.id}/merchant"

    expect(response).to be_success

    invoice_merchant = JSON.parse(response.body)

    expect(invoice_merchant["id"]).to eq(invoice.merchant_id)
  end
end
