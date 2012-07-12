class UserMailer < ActionMailer::Base
  default from: "nigel.purves@gmail.com"

  def song_available(interest)
    @interest = interest
    Rails.logger.info "I'm sending an email to #{@interest.user.email}"
    mail(to: @interest.user.email, subject: "#{@interest.track.name} is available")
  end
end
