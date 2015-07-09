class Post < ActiveRecord::Base
  validates_presence_of :title, :body

  before_save :set_published_at_date

  private

  def set_published_at_date
    if published_changed?(from: false, to: true)
      self.published_at = Date.today
    end
  end
end
