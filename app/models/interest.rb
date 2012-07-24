class Interest < ActiveRecord::Base
  belongs_to :user
  belongs_to :track
#  belongs_to :artist
  
#  attr_accessor :track, :artist            BREAKS MANY THINGS

  accepts_nested_attributes_for :track
        #, :artist

  attr_accessible :track_attributes
        #, :artist_attributes

  # validates :track_id, presence: true     DO NOT UNCOMMENT, BREAKS EVERYTHING!
  validates :user, presence: true
  
  default_scope order: 'interests.created_at DESC'
  scope :reverse_order, order('created_at ASC')

  def position
    self.track.interests.reverse_order.index(self) + 1
  end

  def is_last_interest?
    self.track.interests.count == self.position
  end

  def track_attributes=(attrs)
    Rails.logger.info attrs
    self.track = Track.joins('INNER JOIN "artists" as artist ON "artist"."id" = "tracks"."artist_id"').where(attrs).first_or_initialize
  end
  
#  def artist_attributes=(attrs)
#    self.artist = Artist.where(attrs).first_or_initialize
#  end

end