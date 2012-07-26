class Interest < ActiveRecord::Base
  belongs_to :user
  belongs_to :track
  belongs_to :artist
  
#  attr_accessor :track, :artist            BREAKS MANY THINGS

#  accepts_nested_attributes_for :track, :artist

  attr_accessor :artist_name, :track_name
  
  attr_accessible :track, :track_name, :artist_name

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

  def self.build_interest(track_name, artist_name)
    track_record = Track.joins(:artist).where(name: track_name, :artists => { name: artist_name }).first
    if track_record.nil?
      artist_record = Artist.find_by_name(:artist_name)
      if artist_record.nil?
        artist_record = Artist.create(name: artist_name)
      end
      track_record = Track.create(name: track_name, artist: artist_record)
    end
    Interest.new(track: track_record, track_name: track_name, artist_name: artist_name)
  end
end