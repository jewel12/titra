class Titra < Padrino::Application
  use ActiveRecord::ConnectionAdapters::ConnectionManagement
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers
  register CompassInitializer
  register Padrino::Admin::AccessControl

  enable :sessions

  set :admin_model, 'Translator'

  use OmniAuth::Builder do
    provider :github, ENV['GH_APP_ID'], ENV['GH_APP_SECRET']
    provider :twitter, ENV['TW_APP_ID'], ENV['TW_APP_SECRET']
  end
end
