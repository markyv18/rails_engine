FactoryGirl.define do
  factory :invoice do
    status ["ordered", "paid", "pending", "shipped", "closed"].sample
    customer
    merchant
  end
end
