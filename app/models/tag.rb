class Tag < ActiveRecord::Base
  validates_presence_of :label
  validates_uniqueness_of :label, case_sensitive: false
  validates_length_of :label, maximum: 244
end
