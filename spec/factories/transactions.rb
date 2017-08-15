FactoryGirl.define do
  factory :transaction do
    invoice_id nil
    credit_card_num 1
    credit_card_expiration_date "2017-08-14"
    result 0
  end
end
