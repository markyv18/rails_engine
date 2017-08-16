require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    expect(response).to be_success

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(3)
  end

  it "can get a single merchant by its id" do
    merchant_id = create(:merchant)

    get "/api/v1/merchants/#{merchant_id.id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["name"]).to eq(merchant_id.name)
  end

  it "can create a new merchant" do
    merchant_params = {name: "Harry Boots"}

    post "/api/v1/merchants", params: {merchant: merchant_params}
    merchant = Merchant.last

    expect(response).to be_success
    expect(merchant.name).to eq(merchant_params[:name])
  end

  it "can update an existing merchant" do
    single_merchant = create(:merchant)
    merchant_params = {name: "Harry Boots"}

    put "/api/v1/merchants/#{single_merchant.id}", params: {merchant: merchant_params}
    merchant = Merchant.find_by(id: single_merchant.id)

    expect(response).to be_success
    expect(merchant.name).to_not eq(single_merchant.name)
    expect(merchant.name).to eq("Harry Boots")
  end

  it "can destroy an merchant" do
    merchant = create(:merchant)

    expect(Merchant.count).to eq(1)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_success
    expect(Merchant.count).to eq(0)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  # it "can return the revenue a merchant" do
  #   merchant = create(:merchant)
  #   merchant.items.create(name: "comb", description: "yea", unit_price: 5)
  #   merchant.items.create(name: "hammer", description: "yea", unit_price: 10)
  #   merchant.items.create(name: "flowers", description: "yea", unit_price: 15)
  #
  #   expected = 30
  #
  #   expect(merchant.revenue).to eq expected
  #   expect(Merchant.count).to eq(1)
  #
  #   get "/api/v1/merchants/#{merchant.id}/revenue"
  #
  #   byebug
  #   prs_merchant = JSON.parse(response.body)
  #
  #   expect(response).to be_success
  #   exepect(prs_merchant).to eq(30)
  # end
end
