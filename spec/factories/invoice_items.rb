FactoryGirl.define do
  factory :invoice_item do
    quantity 10
    unit_price 1
    item
    invoice
  end
end
