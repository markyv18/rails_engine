require 'rails_helper'

describe "Transactions Relationship Endpoints" do
  it "returns the associated invoice" do
    invoice = create(:invoice)
    transaction = create(:transaction, invoice: invoice)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    expect(response).to be_success

    transaction_invoice = JSON.parse(response.body)

    expect(transaction.invoice.id).to eq(transaction_invoice["id"])
  end
end
