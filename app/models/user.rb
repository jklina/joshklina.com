class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates_presence_of :name, :email
  validates_length_of :name, maximum: 50
  validates_length_of :email, maximum: 244
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email, with: VALID_EMAIL_REGEX
end
