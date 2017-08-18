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

  it 'can find a merchant by id' do
    create :merchant, id: 1
    get '/api/v1/merchants/find?id=1'

    expected = JSON.parse(response.body)

    expect(expected['id']).to eq(1)
  end

  it 'can find a merchant by name' do
    create :merchant, name: "harder"
    get '/api/v1/merchants/find?name=harder'

    result = JSON.parse(response.body)

    expect(result['name']).to eq('harder')
  end

  it 'can find a merchant by created_at' do
    time = "2012-03-27 14:54:09"
    create :merchant, created_at: time
    get '/api/v1/merchants/find?created_at=' + time.to_s

    result = JSON.parse(response.body)
    new_merchant = Merchant.find(result['id'])

    expect(new_merchant.created_at).to eq(time)
  end

  it 'can find a merchant by updated_at' do
    time = "2012-03-27 14:54:09"
    create :merchant, updated_at: time
    get '/api/v1/merchants/find?updated_at=' + time.to_s

    result = JSON.parse(response.body)
    new_merchant = Merchant.find(result['id'])

    expect(new_merchant.updated_at).to eq(time)
  end

  it 'can find a random merchant' do
    merchant1 = create :merchant
    merchant2 = create :merchant
    get '/api/v1/merchants/random'

    expect(response).to be_success

    response_merchant = JSON.parse(response.body)

    if response_merchant['id'] == merchant1.id
      expect(response_merchant['name']).to eq(merchant1.name)
    elsif response_merchant['id'] == merchant2.id
      expect(response_merchant['name']).to eq(merchant2.name)
    else
      expect('uh oh').to eq('This should not happen')
    end
  end

  it 'can find all merchants by id' do
    create :merchant, id: 1
    create :merchant, id: 2

    get '/api/v1/merchants/find_all?id=1'

    result = JSON.parse(response.body)
    expect(result[0]['id']).to eq 1
    expect(result.count).to eq 1
  end

  it 'can find all merchants by name' do
    create :merchant, name: 'Bart'
    create :merchant, name: 'Bart'
    create :merchant, name: 'Kirby'

    get '/api/v1/merchants/find_all?name=Bart'

    result = JSON.parse(response.body)
    expect(result[0]['name']).to eq 'Bart'
    expect(result[1]['name']).to eq 'Bart'
    expect(result.count).to eq 2
  end

  it 'can find all merchants by created_at' do
    time = "2012-03-27 14:54:09"
    time_two = "2012-03-27 15:54:09"
    create :merchant, created_at: time
    create :merchant, created_at: time
    create :merchant, created_at: time_two

    get '/api/v1/merchants/find_all?created_at=' + time.to_s

    result = JSON.parse(response.body)
    merchants = result.map do |merchant|
      Merchant.find(merchant['id'])
    end

    expect(merchants[0]['created_at']).to eq time
    expect(merchants[1]['created_at']).to eq time
    expect(merchants.count).to eq 2
  end

  it 'can find all merchants by updated_at' do
    time = "2012-03-27 14:54:09"
    time_two = "2012-03-27 15:54:09"
    create :merchant, updated_at: time
    create :merchant, updated_at: time
    create :merchant, updated_at: time_two

    get '/api/v1/merchants/find_all?updated_at=' + time.to_s

    result = JSON.parse(response.body)
    merchants = result.map do |merchant|
      Merchant.find(merchant['id'])
    end

    expect(merchants[0]['updated_at']).to eq time
    expect(merchants[1]['updated_at']).to eq time
    expect(merchants.count).to eq 2
  end
end
