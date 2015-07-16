Dir[Rails.root.join('spec/support/controllers/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include Controllers::SessionManagement, :type => :controller
end
