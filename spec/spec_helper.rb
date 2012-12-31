require 'rubygems'
require 'spork'
require 'factory_girl'
require 'database_cleaner'

Spork.prefork do
  PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
  require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

  RSpec.configure do |conf|
    conf.include Rack::Test::Methods

    conf.before(:suite) do
      DatabaseCleaner.strategy = :truncation
    end

    conf.before(:each) do
      DatabaseCleaner.start
    end

    conf.after(:each) do
      DatabaseCleaner.clean
    end
  end

  def app
    Titra.tap { |app|  }
  end
end

Spork.each_run do
  FactoryGirl.reload
  Padrino.mounted_apps.each { |app| app.app_obj.reload! }
end
