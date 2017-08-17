require 'rails_helper'

describe "Invoice items API can..." do
  it "returns a list/JSON of all invoice_items" do
     create_list(:invoice_item, 5)

      get '/api/v1/invoice_items'

      expect(response).to be_success

      invoice_items = JSON.parse(response.body, symbolize_names: true)

      expect(invoice_items.count).to eq(5)
   end

  it "returns a single JSON invoice_item" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/#{invoice_item.id}"

    invoice_item1 = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(invoice_item1[:id]).to eq(invoice_item.id)
  end

  context "find..." do

    it "an invoice_item by its id" do
      invoice_item1 = create(:invoice_item)
      invoice_item2 = create(:invoice_item)

      get "/api/v1/invoice_items/find?id=#{invoice_item1.id}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(result[:id]).to eq(invoice_item1.id)
      expect(result[:id]).to_not eq(invoice_item2.id)
    end

    it "can find an invoice_item by its quantity" do
      invoice_item1 = create(:invoice_item, quantity: 40)
      invoice_item2 = create(:invoice_item)

      get "/api/v1/invoice_items/find?quantity=#{invoice_item1.quantity}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(result[:quantity]).to eq(invoice_item1.quantity)
      expect(result[:quantity]).to_not eq(invoice_item2.quantity)
    end

    it "can find an invoice_item by its unit price" do
      invoice_item1 = create(:invoice_item, unit_price: 1.25)
      invoice_item2 = create(:invoice_item)

      get "/api/v1/invoice_items/find?unit_price=#{invoice_item1.unit_price}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(result[:id]).to eq(invoice_item1.id)
      expect(result[:id]).to_not eq(invoice_item2.id)
    end

    it "can find an invoice_item by its item id" do
      item1 = create(:item)
      item2 = create(:item)
      invoice_item1 = create(:invoice_item, item: item1)
      invoice_item2 = create(:invoice_item, item: item2)

      get "/api/v1/invoice_items/find?item_id=#{item1.id}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(result[:id]).to eq(invoice_item1.id)
      expect(result[:id]).to_not eq(invoice_item2.id)
    end

    it "can find an invoice_item by when it was created" do
      created = "2017-08-15 13:21:26"
      invoice_item1 = create(:invoice_item, created_at: created)
      invoice_item2 = create(:invoice_item)

      get "/api/v1/invoice_items/find?created_at=#{created}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(result[:id]).to eq(invoice_item1.id)
      expect(result[:id]).to_not eq(invoice_item2.id)
    end

    it "can find an invoice_item by when it was updated" do
      updated = "2017-08-15 13:21:26"
      invoice_item1 = create(:invoice_item, updated_at: updated)
      invoice_item2 = create(:invoice_item)

      get "/api/v1/invoice_items/find?updated_at=#{updated}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(result[:id]).to eq(invoice_item1.id)
      expect(result[:id]).to_not eq(invoice_item2.id)
    end
  end

  context "find_all..." do
    it "can find all invoice_items by their id" do
      invoice_item = create(:invoice_item)
      create_list(:invoice_item, 4)

      get "/api/v1/invoice_items/find_all?id=#{invoice_item.id}"

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(results.count).to eq(1)

      results.each do |result|
        expect(result[:id]).to eq(invoice_item.id)
      end
    end

    it "can find all invoice_items by their quantity" do
      invoice_items = create_list(:invoice_item, 3, quantity: 2)
      create_list(:invoice_item, 4)

      get "/api/v1/invoice_items/find_all?quantity=#{invoice_items.first.quantity}"

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(results.count).to eq(3)

      results.each do |result|
        expect(result[:quantity]).to eq(2)
      end
    end

    it "can find all invoice_items by their quantity" do
      invoice_items = create_list(:invoice_item, 5, quantity: 6)
      create_list(:invoice_item, 4)

      get "/api/v1/invoice_items/find_all?quantity=#{invoice_items.first.quantity}"

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(results.count).to eq(5)

      results.each do |result|
        expect(result[:quantity]).to eq(6)
      end
    end

    it "can find all invoice_items by their unit price" do
      invoice_items = create_list(:invoice_item, 3, unit_price: 52)
      create_list(:invoice_item, 4)

      get "/api/v1/invoice_items/find_all?unit_price=#{invoice_items.first.unit_price}"

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(results.count).to eq(3)

      results.each do |result|
        expect(result[:unit_price]).to eq(52)
      end
    end

    it "can find all invoice_items by their item's id" do
      item = create(:item)
      invoice_items = create_list(:invoice_item, 5, item: item)
      create_list(:invoice_item, 4)

      get "/api/v1/invoice_items/find_all?item_id=#{item.id}"

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(results.count).to eq(5)

      results.each do |result|
        expect(result[:item_id]).to eq(item.id)
      end
    end

    it "can find all invoice_items by when they were created" do
      created = "2017-08-15 13:22:26"
      invoice_items = create_list(:invoice_item, 2, created_at: created)
      create_list(:invoice_item, 4)

      get "/api/v1/invoice_items/find_all?created_at=#{created}"

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(results.count).to eq(2)

      expect(results.first[:id]).to eq(invoice_items.first.id)
      expect(results.second[:id]).to eq(invoice_items.second.id)
    end

    it "can find all invoice_items by when they were updated" do
      updated = "2017-08-15 13:22:26"
      invoice_items = create_list(:invoice_item, 3, updated_at: updated)
      create_list(:invoice_item, 2)

      get "/api/v1/invoice_items/find_all?updated_at=#{updated}"

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(results.count).to eq(3)

      expect(results.first[:id]).to eq(invoice_items.first.id)
      expect(results.second[:id]).to eq(invoice_items.second.id)
      expect(results.third[:id]).to eq(invoice_items.third.id)
    end
  end

    it "can find a random invoice_item" do
      create_list(:invoice_item, 3)

      get '/api/v1/invoice_items/random'

      invoice_item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(invoice_item).to be_a(Hash)
      expect(invoice_item).to have_key(:unit_price)
      expect(invoice_item).to have_key(:quantity)
      expect(invoice_item).to have_key(:invoice_id)
      expect(invoice_item).to have_key(:item_id)
    end
end
