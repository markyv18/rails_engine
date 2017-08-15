FactoryGirl.define do
  factory :customer do
    sequence :first_name do |t|
      "#{t} first-name"
    end
    sequence :last_name do |t|
      "#{t} last-name"
    end
  end
end
