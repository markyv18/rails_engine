require 'rails_helper'

describe "Customer Relationship Endpoint" do
  it "returns a collection of invoices associated with a customer" do
    customer = create(:customer)
    invoices = create_list(:invoice, 28, customer: customer)

    get "/api/v1/customers/#{customer.id}/invoices"

    expect(response).to be_success

    customer_invoices = JSON.parse(response.body)

    expect(customer_invoices.count).to eq(28)

    expect(customer_invoices.all? {
        |invoice_hash|
        Invoice.find(invoice_hash["id"]).customer_id == customer.id}).to be true
  end

  it "returns a collection of associated transactions for an specific customer" do
    customer = create(:customer)
    invoice_1 = create(:invoice, customer: customer)
    invoice_2 = create(:invoice, customer: customer)
    transactions_1 = create(:transaction, invoice: invoice_1)
    transactions_2 = create(:transaction, invoice: invoice_2)

    get "/api/v1/customers/#{customer.id}/transactions"

    expect(response).to be_success

    customer_transactions = JSON.parse(response.body)

    expect(customer_transactions.first["invoice_id"]).to eq(invoice_1.id)
    expect(customer_transactions.last["invoice_id"]).to eq(invoice_2.id)
  end
end
