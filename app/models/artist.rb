class Artist < ActiveRecord::Base
  require 'spotify'
  
  attr_accessible :name
  has_many :interests, through: :tracks
  has_many :tracks
  
  validates :name,  presence: true, length: { maximum: 140 }
  
  # need to do the below with a broader search, == is too narrow at the moment
  
  def spotify_artist_catalogue
    spotify_artist_search.select { |track| track.artists[0].name == "#{name}" }
  end
  
  def spotify_artist_search
    result = []
    (1..100).each do |a| 
      result << Spotify.search_track("#{name}", page: a)
    end
    r = result.compact.flatten
    r.select { |track| track.album.availability['territories'].split(" ").include? "GB" }
  end
  
end