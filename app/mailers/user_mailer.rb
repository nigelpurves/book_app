class UserMailer < ActionMailer::Base
  default from: "nigel.purves@gmail.com"

  def track_available(interest)
    @interest = interest
    Rails.logger.info "I'm sending an email to #{@interest.user.email}"
    mail(to: @interest.user.email, subject: "#{@interest.track.name} is available")
  end
  
  def artist_new_release(interest)
    @interest = interest
    @new_tracks = interest.get_new_tracks
    Rails.logger.info "I'm sending an email to #{@interest.user.email}"
    mail(to: @interest.user.email, subject: "#{@interest.name} have released some new tracks!")
  end
end
