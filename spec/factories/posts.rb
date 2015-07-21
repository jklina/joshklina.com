FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.word }
    body { Faker::Lorem.paragraph(2) }
    association :author, factory: :user
  end
end
