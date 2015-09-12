FactoryGirl.define do
  factory :book_review do
    sequence(:book_title) { |n| "Title#{n}" }
    url "http://my-book"
    image_url "http://images.com/image.jpg"
    body "My review."
    book_author "Arthur"
    association :author, factory: :user
  end
end
