FactoryGirl.define do
  factory :post, class: 'Exposition::Post' do
    sequence(:title) { |n| "Title#{n}" }
    body { Faker::Lorem.paragraph(2) }
    summary { Faker::Lorem.paragraph(1) }
    association :author, factory: :user
  end
end
