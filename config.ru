# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

require 'resque/server'

map "/admin/resque" do
  use Rack::Auth::Basic, "Restricted Area" do |username, password|
    secret_file = File.expand_path("~/resque_password")
    secret = File.exist?(secret_file) ? File.read(secret_file).strip : 'password'
    [username, password] == ['admin', secret]
  end
  run Resque::Server.new
end

map '/' do
  run GameChecker::Application
end
