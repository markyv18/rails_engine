require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  it 'InvoiceItem has attributes' do
    invoice_item = create(:invoice_item)

    expect(invoice_item).to respond_to(:item_id)
    expect(invoice_item).to respond_to(:invoice_id)
    expect(invoice_item).to respond_to(:quantity)
    expect(invoice_item).to respond_to(:unit_price)
    expect(invoice_item).to respond_to(:created_at)
    expect(invoice_item).to respond_to(:updated_at)

  end
end
