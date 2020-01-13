require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Exposition
  class Application < Rails::Application
    config.generators do |g|
      g.assets = false
      g.helper = false
      g.view_specs = false
    end
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
  end
end
