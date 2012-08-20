class Artist < ActiveRecord::Base
  require 'spotify'
  
  attr_accessible :name
  has_many :artist_interests
  has_many :track_interests, through: :tracks
  has_many :tracks
  
  validates :name,  presence: true, length: { maximum: 140 }
  
  def self.update_catalogue
    self.all.each do |artist|
      artist.spotify_catalogue_download
    end
  end
  
  def is_new?
    # This means artists created less than 24 hours ago because times within the last 24 hours are greater than the time 24 hours ago
    self.created_at > 24.hours.ago 
  end
  
  def spotify_catalogue_download
    spotify_artist_catalogue.each do |entry|
      track_record = self.tracks.where('lower("tracks"."name") = ?', entry.name.downcase).first
      if track_record.nil?
        track_record = Track.new(name: entry.name, artist: self)
        track_record.lookup_links
        if self.is_new?
          track_record.discovered_at = 1.year.ago
        else
          track_record.discovered_at = Time.now
        end
        track_record.save
      end
    end
  end
  
  def spotify_artist_catalogue
    result = []
    (1..100).each do |a| 
      result << Spotify.search_track(self.name, page: a)
    end
    r = result.compact.flatten
    c = r.select { |track| track.album.availability['territories'].split(" ").include? "GB" }
    spotify_artist_catalogue = c.select { |track| track.artists[0].name.downcase == self.name.downcase }
  end
end