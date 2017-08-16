require 'rails_helper'

describe "Transactions API" do
  it "sends a list of transactions" do
    create_list(:transaction, 3)

    get "/api/v1/transactions"

    expect(response).to be_success

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(3)
  end

  it "can get a single transaction by its id" do
    transaction_id = create(:transaction).id

    get "/api/v1/transactions/#{transaction_id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["id"]).to eq(transaction_id)
  end

  it "can create a new transaction" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = Invoice.create(id: 5, customer_id: customer.id, merchant_id: merchant.id)
    transaction_params = {invoice_id: invoice.id, credit_card_num: "1234567890", result: "success"}

    post "/api/v1/transactions", params: {transaction: transaction_params}
    expect(response).to be_success
    transaction = Transaction.last

    expect(transaction.id).to eq(transaction_params[:invoice_id])
    expect(transaction.credit_card_num).to eq(transaction_params[:credit_card_num])
    expect(transaction.result).to eq(transaction_params[:result])
  end

  it "can update an existing transaction" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = Invoice.create(id: 6, customer_id: customer.id, merchant_id: merchant.id)
    transaction_params = {invoice_id: 6, credit_card_num: "1234567890", result: "success"}
    single_transaction = create(:transaction)

    put "/api/v1/transactions/#{single_transaction.id}", params: {transaction: transaction_params}
    transaction = Transaction.find_by(id: single_transaction.id)

    expect(response).to be_success
    expect(transaction.id).to eq(transaction_params[:invoice_id])
    expect(transaction.credit_card_num).to eq(transaction_params[:credit_card_num])
    expect(transaction.result).to eq(transaction_params[:result])
  end

  it "can destroy an transaction" do
    transaction = create(:transaction)

    expect(Transaction.count).to eq(1)

    delete "/api/v1/transactions/#{transaction.id}"

    expect(response).to be_success
    expect(Transaction.count).to eq(0)
    expect{Transaction.find(transaction.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
