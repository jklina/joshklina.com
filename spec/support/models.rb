Dir[Rails.root.join('spec/support/models/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include Models::Sluggable, :type => :model
end
