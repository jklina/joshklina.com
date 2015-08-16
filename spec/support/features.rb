Dir[Rails.root.join('spec/support/features/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include Features::SessionManagement, :type => :feature
  config.include Features::Pagination, :type => :feature
end
