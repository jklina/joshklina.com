module Publishable
  extend ActiveSupport::Concern

  included do
    before_save :set_published_at_date
  end

  def css_classes
    if published?
      return "published"
    else
      return "not-published"
    end
  end

  private

  def set_published_at_date
    if published_changed?(from: false, to: true)
      self.published_at = Date.today
    end
  end

  module ClassMethods
    def published
      where(published: true)
    end

    def sorted_by_published_date
      order(published_at: :desc)
    end
  end
end
