class AvailableMailer < ActionMailer::Base
  # default from: "nigel.purves@gmail.com"
  
  def song_available(user)
    mail(to: user.email, subject: "Your song is available", from: "nigel.purves@gmail.com")
  end
end
