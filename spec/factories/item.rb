  FactoryGirl.define do
    factory :item do
      name {Faker::Name.name}
      description {Faker::Name.last_name}
      unit_price 10
      merchant 
    end
  end
