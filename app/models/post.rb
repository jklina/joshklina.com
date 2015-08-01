class Post < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  has_many :taggings
  has_many :tags, through: :taggings

  validates_presence_of :title, :body, :slug, :author
  validates_uniqueness_of :slug, case_sensitive: false
  validates_length_of :slug, :title, maximum: 244

  before_validation :prepare_slug
  before_save :set_published_at_date

  def css_classes
    if published?
      return "published"
    else
      return "not-published"
    end
  end

  def self.published
    where(published: true)
  end

  def to_param
    slug
  end

  private

  def set_published_at_date
    if published_changed?(from: false, to: true)
      self.published_at = Date.today
    end
  end

  def prepare_slug
    unless slug.present?
      self.slug = title
    end
    self.slug = slug.to_s
    self.slug = slug.parameterize
  end
end
