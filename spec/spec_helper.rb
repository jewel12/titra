require 'rubygems'
require 'spork'
require 'factory_girl'

Spork.prefork do
  PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
  require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

  RSpec.configure do |conf|
    conf.include Rack::Test::Methods
  end

  FactoryGirl.definition_file_paths = [File.join(Padrino.root, 'spec', 'factories')]
  FactoryGirl.find_definitions

  def app
    Titra.tap { |app|  }
  end
end

Spork.each_run do
  Padrino.mounted_apps.each { |app| app.app_obj.reload! }
end


