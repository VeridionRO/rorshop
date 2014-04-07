require 'rubygems'
require 'spork'
require 'capybara/rspec'

Capybara.javascript_driver = :webkit

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'

  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
  Dir[Rails.root.join("spec/helpers/*.rb")].each { |f| require f }
  ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)
  RSpec.configure do |config|
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true 
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.order = "random"
    config.include Capybara::DSL, :type => :request
  end
end

Spork.each_run do
end