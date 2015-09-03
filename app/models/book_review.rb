class BookReview < ActiveRecord::Base
  include Sluggable
  include Publishable
  validates_presence_of :title, :review, :author
  validates_length_of :title, :author, maximum: 244

  sluggify :slug, generated_from: :title
end
