FactoryGirl.define do
  factory :tag do
    sequence(:label) { |n| "label#{n}" }
  end

end
