class TrackInterest < Interest

  delegate :name, :itunes_link, :spotify_link, to: :track

  attr_accessible :track

  validates_presence_of :track

  def position
    self.track.track_interests.reverse_order.index(self) + 1
  end

  def is_last_interest?
    self.track.track_interests.count == self.position
  end
  
  def artist_name
    track.artist.name
  end
  
  def notify_user!
    UserMailer.track_available(self).deliver
    self.update_attribute(:last_notified_at, Time.now)
  end
end
