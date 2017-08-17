FactoryGirl.define do
  factory :transaction do
    invoice
    credit_card_number 1
    credit_card_expiration_date "2017-08-14"
    result 0
  end
end
