FactoryGirl.define do
  factory :tool do
    sequence(:title) { |n| "Title#{n}" }
    url "http://my-tool"
    body "My tool review."
  end
end
