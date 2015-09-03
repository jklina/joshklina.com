FactoryGirl.define do
  factory :book_review do
    sequence(:title) { |n| "Title#{n}" }
    url "http://my-book"
    image_url "http://images.com/image.jpg"
    review "My review."
    author "Arthur"
  end
end
