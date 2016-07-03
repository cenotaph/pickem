require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Pickem
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end



# Omniauth keys here
if Rails.env.production?
  APPROVED_USERS = ENV['APPROVED_USERS'].split(/\,\s*/).to_a
  APPROVED_ADMINS = ENV['APPROVED_ADMINS'].split(/\,\s*/).to_a
  # put users here who are approved to log in 
  # APPROVED_ADMINS = [] # put approved admin email addresses here
  OER_API_KEY = ENV['OPEN_EXCHANGE_KEY']
  
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, ENV['google_app_id'], ENV['google_secret'] , {
      scope: "email", # access_type: 'offline', approval_prompt: '', 
      client_options: {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}} 
    }
  end
end
