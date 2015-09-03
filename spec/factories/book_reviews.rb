FactoryGirl.define do
  factory :book_review do
    title "My Book"
    url "http://my-book"
    image_url "http://images.com/image.jpg"
    review "My review."
    author "Arthur"
  end
end
