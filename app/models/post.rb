class Post < ActiveRecord::Base
  validates_presence_of :title, :body, :slug
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
