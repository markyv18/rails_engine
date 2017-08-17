require 'rails_helper'

describe "Items API can..." do
  it "returns a list/JSON of all items" do
     create_list(:item, 5)

      get '/api/v1/items'

      expect(response).to be_success

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items.count).to eq(5)
   end

  it "returns a single JSON item" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(item[:id]).to eq(id)
  end

  context "find..." do
    it "all items" do
      item1 = create(:item, name: "beach balls")
      item2 = create(:item)

      get "/api/v1/items/find?name=#{item1.name}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(result[:id]).to eq(item1.id)
      expect(result[:id]).to_not eq(item2.id)
    end

    it "an item by its id" do
      item1 = create(:item)
      item2 = create(:item)

      get "/api/v1/items/find?id=#{item1.id}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(result[:id]).to eq(item1.id)
      expect(result[:id]).to_not eq(item2.id)
    end

    it "can find an item by its description" do
      item1 = create(:item, description: "awesome")
      item2 = create(:item)

      get "/api/v1/items/find?description=#{item1.description}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(result[:id]).to eq(item1.id)
      expect(result[:id]).to_not eq(item2.id)
    end

    it "can find an item by its unit price" do
      item1 = create(:item, unit_price: 1.25)
      item2 = create(:item)

      get "/api/v1/items/find?unit_price=#{item1.unit_price}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(result[:id]).to eq(item1.id)
      expect(result[:id]).to_not eq(item2.id)
    end

    it "can find an item by its merchant id" do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      item1 = create(:item, merchant: merchant1)
      item2 = create(:item, merchant: merchant2)

      get "/api/v1/items/find?merchant_id=#{merchant1.id}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(result[:id]).to eq(item1.id)
      expect(result[:id]).to_not eq(item2.id)
    end

    it "can find an item by when it was created" do
      created = "2017-08-15 13:21:26"
      item1 = create(:item, created_at: created)
      item2 = create(:item)

      get "/api/v1/items/find?created_at=#{created}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(result[:id]).to eq(item1.id)
      expect(result[:id]).to_not eq(item2.id)
    end

    it "can find an item by when it was updated" do
      updated = "2017-08-15 13:21:26"
      item1 = create(:item, updated_at: updated)
      item2 = create(:item)

      get "/api/v1/items/find?updated_at=#{updated}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(result[:id]).to eq(item1.id)
      expect(result[:id]).to_not eq(item2.id)
    end
  end

  context "find_all..." do
    it "can find all items by their id" do
      item = create(:item)
      create_list(:item, 4)

      get "/api/v1/items/find_all?id=#{item.id}"

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(results.count).to eq(1)

      results.each do |result|
        expect(result[:id]).to eq(item.id)
      end
    end

    it "can find all items by their name" do
      items = create_list(:item, 3, name: "beavis")
      create_list(:item, 4)

      get "/api/v1/items/find_all?name=#{items.first.name}"

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(results.count).to eq(3)

      results.each do |result|
        expect(result[:name]).to eq("beavis")
      end
    end

    it "can find all items by their description" do
      items = create_list(:item, 5, description: "hot dog")
      create_list(:item, 4)

      get "/api/v1/items/find_all?description=#{items.first.description}"

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(results.count).to eq(5)

      results.each do |result|
        expect(result[:description]).to eq("hot dog")
      end
    end

    it "can find all items by their unit price" do
      items = create_list(:item, 3, unit_price: 52.81)
      create_list(:item, 4)

      get "/api/v1/items/find_all?unit_price=#{items.first.unit_price}"

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(results.count).to eq(3)

      results.each do |result|
        expect(result[:unit_price]).to eq("52.81")
      end
    end

    it "can find all items by their merchant's id" do
      merchant = create(:merchant)
      items = create_list(:item, 5, merchant: merchant)
      create_list(:item, 4)

      get "/api/v1/items/find_all?merchant_id=#{merchant.id}"

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(results.count).to eq(5)

      results.each do |result|
        expect(result[:merchant_id]).to eq(merchant.id)
      end
    end

    it "can find all items by when they were created" do
      created = "2017-08-15 13:22:26"
      items = create_list(:item, 2, created_at: created)
      create_list(:item, 4)

      get "/api/v1/items/find_all?created_at=#{created}"

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(results.count).to eq(2)

      expect(results.first[:id]).to eq(items.first.id)
      expect(results.second[:id]).to eq(items.second.id)
    end

    it "can find all items by when they were updated" do
      updated = "2017-08-15 13:22:26"
      items = create_list(:item, 3, updated_at: updated)
      create_list(:item, 2)

      get "/api/v1/items/find_all?updated_at=#{updated}"

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(results.count).to eq(3)

      expect(results.first[:id]).to eq(items.first.id)
      expect(results.second[:id]).to eq(items.second.id)
      expect(results.third[:id]).to eq(items.third.id)
    end
  end

    it "can find a random item" do
      create_list(:item, 3)

      get '/api/v1/items/random'

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(item).to be_a(Hash)
      expect(item).to have_key(:name)
      expect(item).to have_key(:description)
      expect(item).to have_key(:unit_price)
      expect(item).to have_key(:merchant_id)
    end
end
