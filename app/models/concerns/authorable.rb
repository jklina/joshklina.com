module Authorable
  extend ActiveSupport::Concern

  included do
    belongs_to :author, class_name: 'User'
    validates_presence_of :author
  end
end
