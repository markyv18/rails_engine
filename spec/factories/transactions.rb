require 'faker'

FactoryGirl.define do
  factory :transaction do
    credit_card_num { Faker::Business.credit_card_number }
    result ["success", "denied", "pending"].sample
    credit_card_expiration_date "2017-08-14"
    invoice
  end
end
