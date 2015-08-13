module Sluggable
  extend ActiveSupport::Concern

  included do
    validates_presence_of :slug
    validates_uniqueness_of :slug, case_sensitive: false
    validates_length_of :slug, maximum: 244

    before_validation :prepare_slug
  end

  module ClassMethods
    def sluggify(slug_param=:slug, generated_from:)
      define_method(:to_param) do
        send(slug_param)
      end

      define_method(:prepare_slug) do
        unless send(slug_param).present?
          self.send("#{slug_param}=", send(generated_from))
        end
        self.send("#{slug_param}=", send(slug_param).to_s)
        self.send("#{slug_param}=", send(slug_param).parameterize)
      end
    end
  end
end
