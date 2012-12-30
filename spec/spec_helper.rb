require 'rubygems'
require 'spork'

Spork.prefork do
  PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
  require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

  RSpec.configure do |conf|
    conf.include Rack::Test::Methods
  end

  def app
    Titra.tap { |app|  }
  end
end

Spork.each_run do
end


