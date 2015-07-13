class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  attr_accessor :remember_token

  validates_presence_of :name, :email
  validates_length_of :name, maximum: 50
  validates_length_of :email, maximum: 244
  validates_length_of :password, minimum: 6
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email, with: VALID_EMAIL_REGEX

  has_secure_password

  # Remembers a user in the database for use in persistent sessions.
  def set_encrypted_remember_token!
    self.remember_token = User.generate_new_token
    update_attribute(:remember_digest, Encryptor.encrypt(remember_token))
  end

  def self.generate_new_token
    SecureRandom.urlsafe_base64
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
