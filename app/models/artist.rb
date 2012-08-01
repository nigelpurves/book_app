class Artist < ActiveRecord::Base
  require 'spotify'
  
  attr_accessible :name
  has_many :artist_interests
  has_many :track_interests, through: :tracks
  has_many :tracks
  
  validates :name,  presence: true, length: { maximum: 140 }
  
  def spotify_download_catalogue
    spotify_artist_catalogue.each do |entry|
      track_record = self.tracks.where('lower("tracks"."name") = ?', entry.name.downcase).first
      if track_record.nil?
        track_record = Track.new(name: entry.name, artist: self)
        track_record.lookup_links
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