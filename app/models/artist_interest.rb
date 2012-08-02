class ArtistInterest < Interest
  
  delegate :name, to: :artist
  
  #belongs_to :artist
  attr_accessible :artist

  validates_presence_of :artist

  def position
    self.artist.artist_interests.reverse_order.index(self) + 1
  end

  def is_last_interest?
    self.artist.artist_interests.count == self.position
  end
  
  def notify_user!
    UserMailer.artist_new_release(self).deliver
    self.update_attribute(:last_notified_at, Time.now)
  end
  
  def self.notify_all_users
    self.all.each do |ai|
      ai.notify_user!
    end
  end
  
  def get_new_tracks
    self.artist.tracks.where("discovered_at > ?", self.last_notified_at)
  end
end
