class BookReview < ActiveRecord::Base
  include Authorable
  include HumanUrls::Sluggable
  include Publishable
  include Categorical::Taggable

  validates_presence_of :book_title, :body, :book_author
  validates_length_of :book_title, :book_author, maximum: 244

  sluggify :slug, generated_from: :book_title
end
