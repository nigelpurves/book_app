# CHANGE THESE DETAILS FOR PRODUCTION

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "qusic.herokuapp.com",
  :user_name            => "qusic",
  :password             => "qusic",
  :authentication       => "plain",
  :enable_starttls_auto => true
}