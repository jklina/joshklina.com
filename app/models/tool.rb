class Tool < ApplicationRecord
  include HumanUrls::Sluggable
  include Publishable
  include Categorical::Taggable

  validates_presence_of :title, :body
  validates_length_of :title, maximum: 244

  sluggify :slug, generated_from: :title
end
