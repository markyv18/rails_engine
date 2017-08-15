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
    customer_id = create(:customer).id

    get "/api/v1/customers/#{customer_id}"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer["id"]).to eq(customer_id)
  end

  it "can create a new customer" do
    customer_params = {first_name: "Harry", last_name: "Boots"}

    post "/api/v1/customers", params: {customer: customer_params}
    customer = Customer.last

    expect(response).to be_success
    expect(customer.first_name).to eq(customer_params[:first_name])
    expect(customer.last_name).to eq(customer_params[:last_name])
  end

  it "can update an existing customer" do
    single_customer = create(:customer)
    customer_params = {first_name: "Harry", last_name: "Boots"}

    put "/api/v1/customers/#{single_customer.id}", params: {customer: customer_params}
    customer = Customer.find_by(id: single_customer.id)

    expect(response).to be_success
    expect(customer.name).to_not eq(single_customer.name)
    expect(customer.name).to eq("Harry Boots")
  end

  it "can destroy an customer" do
    customer = create(:customer)

    expect(Customer.count).to eq(1)

    delete "/api/v1/customers/#{customer.id}"

    expect(response).to be_success
    expect(Customer.count).to eq(0)
    expect{Customer.find(customer.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
