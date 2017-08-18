require 'rails_helper'

describe "InvoiceItems Relationship Endpoint" do
  it "returns the associated invoice" do
    invoice = create(:invoice)
    invoice_item = create(:invoice_item, invoice: invoice)

      get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

      expect(response).to be_success

      invoice_item_invoice = JSON.parse(response.body)

      expect(invoice_item.invoice["id"]).to eq(invoice.id)
  end

  it "returns the associated item for the invoice item" do
    item = create(:item)
    invoice_item = create(:invoice_item, item: item)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    expect(response).to be_success

    invoice_item_item = JSON.parse(response.body)

    expect(item.id).to eq(invoice_item.item["id"])
    expect(item.name).to eq(invoice_item.item["name"])
  end
end
