FactoryGirl.define do
  factory :tag, class: Categorical::Tag do
    sequence(:label) { |n| "label#{n}" }
  end
end
