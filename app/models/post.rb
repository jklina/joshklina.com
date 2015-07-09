class Post < ActiveRecord::Base
  validates_presence_of :title, :body

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
end
