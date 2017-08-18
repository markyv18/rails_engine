require 'rails_helper'

describe "Items Relationship Endpoint" do
  it "returns a collection of associated invoice items" do
    item = create(:item)
    invoice_items = create_list(:invoice_item, 5, item: item)

      get "/api/v1/items/#{item.id}/invoice_items"

      expect(response).to be_success

      item_invoice_items = JSON.parse(response.body)

      expect(item_invoice_items.count).to eq(5)

      expect(item.id).to eq(item_invoice_items.first["item_id"])
      expect(item.id).to eq(item_invoice_items.last["item_id"])
  end

  it " returns the associated merchant for an item" do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_success

    item_merchant = JSON.parse(response.body)

    expect(merchant.id).to eq(item_merchant["id"])
    expect(merchant.name).to eq(item_merchant["name"])
    expect(merchant.name).to eq(item.merchant.name)
  end
end
