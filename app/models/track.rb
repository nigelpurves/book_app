class Track < ActiveRecord::Base
  require 'spotify'

  attr_accessible :artist, :name
  has_many :interests
  has_many :users, through: :interests

  validates :artist,  presence: true, length: { maximum: 140 }
  validates :name,    presence: true, length: { maximum: 140 }

  before_create :lookup_links, :titlecase_name
  
  def titlecase_name
    self.artist = self.artist.titleize
    self.name   = self.name.titleize
  end

  def lookup_links
    lookup_spotify_link
    lookup_itunes_link
  end

  def lookup_spotify_link
    spotify_info = Spotify.search_track("#{artist} #{name}").try(:first)
    
    if spotify_info
      if spotify_info.album.availability['territories'].split(" ").include? "GB"
        spotify_id = spotify_info.href.split("track:")[1]
        self.spotify_link = "http://open.spotify.com/track/#{spotify_id}"
      end
    end
  end

  def lookup_itunes_link
    itunes_info = ITunesSearchAPI.search(
      :term => "#{artist} #{name}",
      :entity=> "song",
      :country => "GB",
      :media => "music",
      :limit => "1"
    ).first

    self.itunes_link = itunes_info["trackViewUrl"] if itunes_info.present?
  end

  def self.update_links
    tracks = self.where("itunes_link IS NULL OR spotify_link IS NULL").all

    tracks.each do |track|
      track.lookup_links
      if track.spotify_link_changed? || track.itunes_link_changed?
        track.save!
        track.interests.each do |interest|
          UserMailer.song_available(interest.id).deliver
        end
      end
    end
  end
end
