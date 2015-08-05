class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :posts, through: :taggings

  validates_presence_of :label
  validates_uniqueness_of :label, case_sensitive: false
  validates_length_of :label, maximum: 244

  def to_s
    label
  end
end
