require 'rails_helper'

describe "Invoices API can..." do
  it "returns a list/JSON of all invoices" do
     create_list(:invoice, 5)

      get '/api/v1/invoices'

      expect(response).to be_success

      invoices = JSON.parse(response.body, symbolize_names: true)

      expect(invoices.count).to eq(5)
   end

  it "returns a single JSON invoice" do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(invoice[:id]).to eq(id)
  end

  context "find..." do
    it "an invoice by its id" do
      invoice1 = create(:invoice)
      invoice2 = create(:invoice)

      get "/api/v1/invoices/find?id=#{invoice1.id}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(result[:id]).to eq(invoice1.id)
      expect(result[:id]).to_not eq(invoice2.id)
    end

    it "can find an invoice by its status" do
      invoice1 = create(:invoice)
      invoice2 = create(:invoice)

      get "/api/v1/invoices/find?description=#{invoice1.status}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(result[:id]).to eq(invoice1.id)
      expect(result[:id]).to_not eq(invoice2.id)
    end

    it "can find an invoice by its customer_id" do
      invoice1 = create(:invoice)
      invoice2 = create(:invoice)

      get "/api/v1/invoices/find?unit_price=#{invoice1.customer_id}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(result[:id]).to eq(invoice1.id)
      expect(result[:id]).to_not eq(invoice2.id)
    end

    it "can find an invoice by its merchant id" do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      invoice1 = create(:invoice, merchant: merchant1)
      invoice2 = create(:invoice, merchant: merchant2)

      get "/api/v1/invoices/find?merchant_id=#{merchant1.id}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(result[:id]).to eq(invoice1.id)
      expect(result[:id]).to_not eq(invoice2.id)
    end

    it "can find an invoice by when it was created" do
      created = "2017-08-15 13:21:26"
      invoice1 = create(:invoice, created_at: created)
      invoice2 = create(:invoice)

      get "/api/v1/invoices/find?created_at=#{created}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(result[:id]).to eq(invoice1.id)
      expect(result[:id]).to_not eq(invoice2.id)
    end

    it "can find an invoice by when it was updated" do
      updated = "2017-08-15 13:21:26"
      invoice1 = create(:invoice, updated_at: updated)
      invoice2 = create(:invoice)

      get "/api/v1/invoices/find?updated_at=#{updated}"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(result[:id]).to eq(invoice1.id)
      expect(result[:id]).to_not eq(invoice2.id)
    end
  end

  context "find_all..." do
    it "can find all invoices by their id" do
      invoice = create(:invoice)
      create_list(:invoice, 4)

      get "/api/v1/invoices/find_all?id=#{invoice.id}"

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(results.count).to eq(1)

      results.each do |result|
        expect(result[:id]).to eq(invoice.id)
      end
    end

    it "can find all invoices by their status" do
      invoices = create_list(:invoice, 3, status: "paid")
      invoices << create_list(:invoice, 4, status: "pending")

      get "/api/v1/invoices/find_all?status=paid"

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(results.count).to eq(3)

      results.each do |result|
        expect(result[:status]).to eq("paid")
      end
    end

    it "can find all invoices by their merchant's id" do
      merchant = create(:merchant)
      invoices = create_list(:invoice, 5, merchant: merchant)
      create_list(:invoice, 4)

      get "/api/v1/invoices/find_all?merchant_id=#{merchant.id}"

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(results.count).to eq(5)

      results.each do |result|
        expect(result[:merchant_id]).to eq(merchant.id)
      end
    end

    it "can find all invoices by their customer's id" do
      customer = create(:customer)
      invoices = create_list(:invoice, 5, customer: customer)
      create_list(:invoice, 4)

      get "/api/v1/invoices/find_all?customer_id=#{customer.id}"

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(results.count).to eq(5)

      results.each do |result|
        expect(result[:customer_id]).to eq(customer.id)
      end
    end

    it "can find all invoices by when they were created" do
      created = "2017-08-15 13:22:26"
      invoices = create_list(:invoice, 2, created_at: created)
      create_list(:invoice, 4)

      get "/api/v1/invoices/find_all?created_at=#{created}"

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(results.count).to eq(2)

      expect(results.first[:id]).to eq(invoices.first.id)
      expect(results.second[:id]).to eq(invoices.second.id)
    end

    it "can find all invoices by when they were updated" do
      updated = "2017-08-15 13:22:26"
      invoices = create_list(:invoice, 3, updated_at: updated)
      create_list(:invoice, 2)

      get "/api/v1/invoices/find_all?updated_at=#{updated}"

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(results.count).to eq(3)

      expect(results.first[:id]).to eq(invoices.first.id)
      expect(results.second[:id]).to eq(invoices.second.id)
      expect(results.third[:id]).to eq(invoices.third.id)
    end
  end

    it "can find a random invoice" do
      create_list(:invoice, 3)

      get '/api/v1/invoices/random'

      invoice = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(invoice).to be_a(Hash)
      expect(invoice).to have_key(:customer_id)
      expect(invoice).to have_key(:id)
      expect(invoice).to have_key(:status)
      expect(invoice).to have_key(:merchant_id)
    end
end
