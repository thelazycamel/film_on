$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'film_on'
require "webmock/rspec"
require "pry"
require_relative "helpers/helper_methods"

RSpec.configure do |c|
  c.include HelperMethods
end

# TODO specs
# Genre service
# Genre Model
# Movie Model
