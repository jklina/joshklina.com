FactoryGirl.define do
  factory :tag do
    label { Faker::Commerce.color }
  end

end
