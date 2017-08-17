FactoryGirl.define do
  factory :merchant do
    sequence :name do |t|
      "#{t} name"
    end
  end
end
