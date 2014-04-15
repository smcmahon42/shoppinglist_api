# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Rails.application

require 'rack/cors'

#config.middleware.insert_before ActionDispatch::Static, Rack::Cors do

use Rack::Cors do
  allow do
    origins 'list_app.dev'

    resource '*', 
        :methods => [:get, :post, :put, :delete, :options],
        :headers => '*',
        :max_age => 17000600
        # headers to expose
  end

  allow do
    origins '*'
    resource '*', :headers => :any, :methods => [:get, :post, :put, :delete, :options]
  end
end
