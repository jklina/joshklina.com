class Categorical::Tag < ActiveRecord::Base
  include Categorical::Concerns::Models::Tag
  include HumanUrls::Sluggable

  sluggify :slug, generated_from: :label
end
