class Post < ActiveRecord::Base
  include Authorable
  include Publishable
  include HumanUrls::Sluggable
  include Categorical::Taggable

  validates_presence_of :title, :body
  validates_length_of :title, maximum: 244

  sluggify :slug, generated_from: :title
end
