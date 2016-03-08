FactoryGirl.define do
  factory :user, class: 'Exposition::User' do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password 'password'
  end
end
