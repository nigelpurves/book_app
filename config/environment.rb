# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
MusicApp::Application.initialize!

# Configuration for using SendGrid on Heroku
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :user_name => "app4890262@heroku.com",
  :password => "q7jynklb",
  :domain => "qusic.herokuapp.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}