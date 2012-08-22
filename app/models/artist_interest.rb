class ArtistInterest < Interest

  delegate :name, to: :artist

  #belongs_to :artist
  attr_accessible :artist

  validates_presence_of :artist

  before_create :update_notification_date

  def position
    self.artist.artist_interests.reverse_order.index(self) + 1
  end

  def is_last_interest?
    self.artist.artist_interests.count == self.position
  end

  def notify_user!
    new_tracks = get_new_tracks
    unless new_tracks.empty?
      UserMailer.artist_new_release(self, new_tracks).deliver
      self.update_attribute(:last_notified_at, Time.now)
    end
  end

  def self.notify_all_users
    self.all.each do |ai|
      ai.notify_user!
    end
  end

  def get_new_tracks
    self.artist.tracks.where("discovered_at > ?", self.last_notified_at)
  end

  private

  def update_notification_date
    self.last_notified_at = Time.now if self.last_notified_at.nil?
  end

end
