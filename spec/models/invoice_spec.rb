require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it 'Invoice has attributes' do
    invoice = create(:invoice)

    expect(invoice).to respond_to(:status)
    expect(invoice).to respond_to(:customer_id)
    expect(invoice).to respond_to(:merchant_id)
    expect(invoice).to respond_to(:created_at)
    expect(invoice).to respond_to(:updated_at)
  end
end
