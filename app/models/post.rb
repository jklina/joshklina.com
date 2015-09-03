class Post < ActiveRecord::Base
  include Sluggable
  include Publishable
  belongs_to :author, class_name: 'User'
  has_many :taggings
  has_many :tags, through: :taggings

  validates_presence_of :title, :body, :author
  validates_length_of :title, maximum: 244

  sluggify :slug, generated_from: :title
end
