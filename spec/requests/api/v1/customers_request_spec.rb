require 'rails_helper'

describe "Customers API" do
  it "sends a list of customers" do
    create_list(:customer, 3)

    get "/api/v1/customers"

    expect(response).to be_success

    customers = JSON.parse(response.body)

    expect(customers.count).to eq(3)
  end

  it "can get a single customer by its id" do
    customer_id = create(:customer)

    get "/api/v1/customers/#{customer_id.id}"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer["first_name"]).to eq(customer_id.first_name)
  end

  it 'can find a customer by id' do
    create :customer, id: 1
    get '/api/v1/customers/find?id=1'

    expected = JSON.parse(response.body)

    expect(expected['id']).to eq(1)
  end

  it 'can find a customer by name' do
    create :customer, first_name: "larrs", last_name: "backwards"
    get '/api/v1/customers/find?first_name=larrs'

    result = JSON.parse(response.body)

    expect(result['first_name']).to eq('larrs')
  end

  it 'can find a customer by created_at' do
    time = "2012-03-27 14:54:09"
    create :customer, created_at: time
    get '/api/v1/customers/find?created_at=' + time.to_s

    result = JSON.parse(response.body)
    new_customer = Customer.find(result['id'])

    expect(new_customer.created_at).to eq(time)
  end

  it 'can find a customer by updated_at' do
    time = "2012-03-27 14:54:09"
    create :customer, updated_at: time
    get '/api/v1/customers/find?updated_at=' + time.to_s

    result = JSON.parse(response.body)
    new_customer = Customer.find(result['id'])

    expect(new_customer.updated_at).to eq(time)
  end

  it 'can find a random customer' do
    customer1 = create :customer
    customer2 = create :customer
    get '/api/v1/customers/random'

    expect(response).to be_success

    response_customer = JSON.parse(response.body)

    if response_customer['id'] == customer1.id
      expect(response_customer['first_name']).to eq(customer1.first_name)
    elsif response_customer['id'] == customer2.id
      expect(response_customer['last_name']).to eq(customer2.last_name)
    else
      expect('uh oh').to eq('This should not happen')
    end
  end

  it 'can find all customers by id' do
    create :customer, id: 1
    create :customer, id: 2

    get '/api/v1/customers/find_all?id=1'

    result = JSON.parse(response.body)
    expect(result[0]['id']).to eq 1
    expect(result.count).to eq 1
  end

  it 'can find all customers by name' do
    create :customer, first_name: 'Bart'
    create :customer, first_name: 'Bart'
    create :customer, last_name: 'Bart'

    get '/api/v1/customers/find_all?first_name=Bart'

    result = JSON.parse(response.body)
    expect(result[0]['first_name']).to eq 'Bart'
    expect(result[1]['first_name']).to eq 'Bart'
    expect(result.count).to eq 2
  end

  it 'can find all customers by created_at' do
    time = "2012-03-27 14:54:09"
    time_two = "2012-03-27 15:54:09"
    create :customer, created_at: time
    create :customer, created_at: time
    create :customer, created_at: time_two

    get '/api/v1/customers/find_all?created_at=' + time.to_s

    result = JSON.parse(response.body)
    customers = result.map do |customer|
      Customer.find(customer['id'])
    end

    expect(customers[0]['created_at']).to eq time
    expect(customers[1]['created_at']).to eq time
    expect(customers.count).to eq 2
  end

  it 'can find all customers by updated_at' do
    time = "2012-03-27 14:54:09"
    time_two = "2012-03-27 15:54:09"
    create :customer, updated_at: time
    create :customer, updated_at: time
    create :customer, updated_at: time_two

    get '/api/v1/customers/find_all?updated_at=' + time.to_s

    result = JSON.parse(response.body)
    customers = result.map do |customer|
      Customer.find(customer['id'])
    end

    expect(customers[0]['updated_at']).to eq time
    expect(customers[1]['updated_at']).to eq time
    expect(customers.count).to eq 2
  end

end
