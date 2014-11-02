ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
FactoryGirl.find_definitions

class ActiveSupport::TestCase
  setup do
    Rails.cache.clear
  end
end
