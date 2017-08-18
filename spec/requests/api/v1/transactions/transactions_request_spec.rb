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

  it "can get a single transaction by its id" do
    transaction_id = create(:transaction)

    get "/api/v1/transactions/#{transaction_id.id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["id"]).to eq(transaction_id.id)
  end

  it 'can find a transaction by id' do
    create :transaction, id: 1
    get '/api/v1/transactions/find?id=1'

    expected = JSON.parse(response.body)

    expect(expected['id']).to eq(1)
  end

  it 'can find a transaction by invoice id' do
    invoice = create(:invoice)
    create :transaction, invoice_id: "#{invoice.id}"
    get '/api/v1/transactions/find?invoice_id=' + invoice.id.to_s

    result = JSON.parse(response.body)

    expect(result['invoice_id']).to eq invoice.id
  end

  it 'can find a transaction by created_at' do
    time = "2012-03-27 14:54:09"
    create :transaction, created_at: time
    get '/api/v1/transactions/find?created_at=' + time.to_s

    result = JSON.parse(response.body)
    new_transaction = Transaction.find(result['id'])

    expect(new_transaction.created_at).to eq(time)
  end

  it 'can find a transaction by updated_at' do
    time = "2012-03-27 14:54:09"
    create :transaction, updated_at: time
    get '/api/v1/transactions/find?updated_at=' + time.to_s

    result = JSON.parse(response.body)
    new_transaction = Transaction.find(result['id'])

    expect(new_transaction.updated_at).to eq(time)
  end

  it 'can find a random transaction' do
    transaction1 = create :transaction
    transaction2 = create :transaction
    get '/api/v1/transactions/random'

    expect(response).to be_success

    response_transaction = JSON.parse(response.body)

    if response_transaction['id'] == transaction1.id
      expect(response_transaction['invoice_id']).to eq(transaction1.invoice_id)
    elsif response_transaction['id'] == transaction2.id
      expect(response_transaction['invoice_id']).to eq(transaction2.invoice_id)
    else
      expect('uh oh').to eq('This should not happen')
    end
  end

  it 'can find all transactions by id' do
    create :transaction, id: 1
    create :transaction, id: 2

    get '/api/v1/transactions/find_all?id=1'

    result = JSON.parse(response.body)
    expect(result[0]['id']).to eq 1
    expect(result.count).to eq 1
  end

  it 'can find all transactions by invoice_id' do
    invoice = create(:invoice)
    create :transaction, invoice_id: invoice.id
    create :transaction, invoice_id: invoice.id
    create :transaction

    get '/api/v1/transactions/find_all?invoice_id=' + invoice.id.to_s

    result = JSON.parse(response.body)
    expect(result[0]['invoice_id']).to eq invoice.id
    expect(result[1]['invoice_id']).to eq invoice.id
    expect(result.count).to eq 2
  end

  it 'can find all transactions by created_at' do
    time = "2012-03-27 14:54:09"
    time_two = "2012-03-27 15:54:09"
    create :transaction, created_at: time
    create :transaction, created_at: time
    create :transaction, created_at: time_two

    get '/api/v1/transactions/find_all?created_at=' + time.to_s

    result = JSON.parse(response.body)
    transactions = result.map do |transaction|
      Transaction.find(transaction['id'])
    end

    expect(transactions[0]['created_at']).to eq time
    expect(transactions[1]['created_at']).to eq time
    expect(transactions.count).to eq 2
  end

  it 'can find all transactions by updated_at' do
    time = "2012-03-27 14:54:09"
    time_two = "2012-03-27 15:54:09"
    create :transaction, updated_at: time
    create :transaction, updated_at: time
    create :transaction, updated_at: time_two

    get '/api/v1/transactions/find_all?updated_at=' + time.to_s

    result = JSON.parse(response.body)
    transactions = result.map do |transaction|
      Transaction.find(transaction['id'])
    end

    expect(transactions[0]['updated_at']).to eq time
    expect(transactions[1]['updated_at']).to eq time
    expect(transactions.count).to eq 2
  end
end
