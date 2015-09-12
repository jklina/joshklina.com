class Tag < ActiveRecord::Base
  include Sluggable
  has_many :taggings

  validates_presence_of :label
  validates_uniqueness_of :label, case_sensitive: false
  validates_length_of :label, maximum: 244

  sluggify :slug, generated_from: :label

  def to_s
    label
  end

  def method_missing(name, *args)
    klass_name = name.to_s.singularize.camelcase
    klass = klass_name.constantize

    klass_instance_ids =
      taggings.where(taggable_type: klass_name).map(&:taggable_id)

    klass.where(id: klass_instance_ids)

    rescue NameError
      super
  end

end
