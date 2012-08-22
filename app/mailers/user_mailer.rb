class UserMailer < ActionMailer::Base

  default from: "QUSIC Tracker <team@qusic.co.uk>"

  def track_available(interest)
    @interest = interest
    Rails.logger.info "[TrackInterest] I'm sending an email to #{@interest.user.email}"
    mail(to: @interest.user.email, subject: "#{@interest.track.name} is available")
  end

  def artist_new_release(interest, new_tracks)
    @interest = interest
    @new_tracks = new_tracks
    Rails.logger.info "[ArtistInterest] I'm sending an email to #{@interest.user.email}"
    mail(to: @interest.user.email, subject: "#{@interest.name} have released some new tracks!")
  end

end
