class Interest < ActiveRecord::Base
  belongs_to :user
  belongs_to :artist
  belongs_to :track

  attr_accessor :artist_name, :track_name

  attr_accessible :artist_name, :track_name

  validates :user, presence: true

  default_scope order: 'interests.created_at DESC'
  scope :reverse_order, order('created_at ASC')

  def position
    self.track.interests.reverse_order.index(self) + 1
  end

  def is_last_interest?
    self.track.interests.count == self.position
  end

  def self.build_track_interest(track_name, artist_name)
    track_record = Track.joins(:artist).where(name: track_name, :artists => {name: artist_name}).first
    if track_record.nil?
      artist_record = Artist.find_by_name(:artist_name)
      if artist_record.nil?
        artist_record = Artist.create(name: artist_name)
      end
      track_record = Track.new(name: track_name, artist: artist_record)
      track_record.lookup_links
      track_record.save
    end
    TrackInterest.new(track: track_record)
  end

  def self.build_artist_interest(artist_name)
    artist_record = Artist.find_by_name(:artist_name)
    if artist_record.nil?
      artist_record = Artist.create(name: artist_name)
    end
    ArtistInterest.new(artist: artist_record)
  end

end
