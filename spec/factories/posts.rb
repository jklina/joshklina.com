FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "Title#{n}" }
    body { Faker::Lorem.paragraph(2) }
    association :author, factory: :user
  end
end
