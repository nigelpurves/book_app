# CHANGE THESE DETAILS FOR PRODUCTION

ActionMailer::Base.smtp_settings = {
  :address        => "smtp.sendgrid.net",
  :port           => "25",
  :authentication => :plain,
  :user_name      => "app424627@heroku.com",
  :password       => "m1jg0exq",
  :domain         => "gocardless.com"
}


